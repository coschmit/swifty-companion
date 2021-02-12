//
//  SearchView.swift
//  Swifty-Companion
//
//  Created by Colin Schmitt on 27/01/2021.
//

import SwiftUI
import SwiftyJSON

extension String {
    
    func load() -> UIImage {
        
        do {
            
            guard let  url = URL(string: self) else {
                return UIImage()
            }
            
            let data: Data = try Data(contentsOf: url)
            
            return UIImage(data: data) ?? UIImage()
            
        } catch {
            
        }
        
        
        return UIImage()
    }
}

struct SearchView: View {
    
    @State private var query: String = ""
    @State private var isLoading = false
    @State private var showingAlert = false
    @State private var isNavActive = false
    
    @State var jsonData: JSON?
    var auth : Auth
    @EnvironmentObject var user : User
    
    
    var body: some View {
        VStack(alignment:.center){
            TextField("Username", text: $query).padding().overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)),lineWidth: 2)).disableAutocorrection(true).autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            
            Button(action: {
                search(username: self.query)
            }, label: {
                Text("Search Profile").padding().frame(width: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(self.query.count > 0 ? Color(#colorLiteral(red: 0.2194311917, green: 0.2383868694, blue: 0.2637918293, alpha: 1)) : Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))).foregroundColor(.white)
            }).disabled(self.query.count > 0 ? false : true)
            
            if self.showingAlert{
                Text("This user doesn't exist").foregroundColor(.red)
            }
            
            if self.isLoading {
                ProgressView()
            }
            
            
            NavigationLink(
                destination: DetailView().environmentObject(self.user),
                isActive: $isNavActive,
                label: {
                    EmptyView()
                })
            
            
            
        }.frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
    
    
    func search(username: String){
        self.isLoading = true
        self.showingAlert = false
        auth.checkUser(username){
            completion in
            if completion != nil {
                self.jsonData = completion
                getProfileInfo(self.jsonData!, newUser: self.user )
                self.isNavActive.toggle()
                self.isLoading = false
            }else {
                self.isLoading = false
                self.showingAlert = true
                print("This login doesn't exists")
            }
        }
        
    }
    
    func parseProjectUser(_ dict:Any, _ cursus42: Bool)-> [UserData]{
        var projectsParsed = [UserData]()
        var i : Int = 0
        let projects = dict as! JSON
        let searchProjectCursus = (cursus42 == true) ? 21 : 1
        for projectVal in projects {
            let projectCursusIds = projectVal.1["cursus_ids"]
            if projectCursusIds.count == 0 {
                continue
            }
            let cursusId = projectCursusIds[0]
            if cursusId.int == searchProjectCursus {
                let projectData = projectVal.1["project"]
                let projectName = projectData["name"].string!
                let projectStatus = projectVal.1["status"].string!
                var isValidated = false
                if  projectVal.1["validated?"].bool != nil {
                     isValidated = projectVal.1["validated?"].bool!
                }
                
                if projectStatus == "finished" {
                    let finalMark = projectVal.1["final_mark"].int!
                    let newProject: UserData = UserData(id: i, name: projectName, state: projectStatus, grade: NSNumber(value: finalMark), validated: isValidated)
                    projectsParsed.append(newProject)
                    i += 1
                }
                else {
                    let newProject: UserData = UserData(id: i, name: projectName, state: projectStatus, grade: NSNumber(0), validated: isValidated)
                    projectsParsed.append(newProject)
                    i += 1
                }
            }
        }
        return projectsParsed
    }
    
    func parseSkillsUser(_ dict: Any) -> [UserData] {
        var skillsParsed = [UserData]()
        var i : Int = 0
        let skills = dict as! JSON
        for skillVal in skills {
            let skill = skillVal.1
            let status = "skill"
            let level =  skill["level"].float!
            let nameSkill = skill["name"].string!
            let newSkill = UserData(id: i, name: nameSkill, state: status, grade: NSNumber(value:level), validated: false)
            skillsParsed.append(newSkill)
            i += 1
        }
        
        
        return skillsParsed
    }
    
    
    func getProfileInfo(_ json: JSON, newUser: User) -> Void{
        var level : Float = json["cursus_users"][0]["level"].float!
        var primaryCursus: Bool = false
        var location: String = "Unavailable"
        var skillsUser = [UserData]()
        let cursusUsers = json["cursus_users"]
        if let locationVal = json["location"].string {
            location = locationVal
        }
        for cursus in cursusUsers {
            let dictCursus = cursus.1
            let dictCursusName = dictCursus["cursus"]
            if let slugValue = dictCursusName["slug"].string{
                if (slugValue == "42" || slugValue == "42cursus") && primaryCursus == false {
                    if slugValue == "42cursus" {
                        level = cursus.1["level"].float!
                        primaryCursus = true
                    }
                    skillsUser = parseSkillsUser(dictCursus["skills"])
                }
            }
        }
       
        newUser.login = json["login"].string!
        newUser.displayName = json["displayname"].string!
        newUser.phone =  json["phone"].string!
        newUser.email = json["email"].string!
        newUser.image = Image(uiImage: json["image_url"].string!.load())
        newUser.location = location
        newUser.level = level
        newUser.projects = parseProjectUser(json["projects_users"], primaryCursus)
        newUser.skills = skillsUser
        
    }
    
    
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(auth: Auth())
    }
}
