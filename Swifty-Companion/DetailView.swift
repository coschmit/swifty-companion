//
//  DetailView.swift
//  Swifty-Companion
//
//  Created by Colin Schmitt on 27/01/2021.
//

import SwiftUI
import SwiftyJSON




struct DetailView: View {
    
    
    @EnvironmentObject var user : User 
    
    
    var body: some View {
    
        
        ZStack {
            Color("Background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                UserProfile(user: user)
                
                
                ScrollView(.vertical){
                    
                    TemplateTableView(title: "Projects", data: user.projects).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).frame(minHeight: 250, maxHeight: 500)
                    
                    
                    Spacer()
                    
                    TemplateTableView(title: "Skills", data: user.skills).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).frame(minHeight:250,maxHeight: 500)
                        
                }
                

            
                
            }.navigationBarTitle(user.login,displayMode: .inline)
        }
        
    }
    
}


struct DetailView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        DetailView()
            .preferredColorScheme(.dark)
            .environmentObject(User())
            .previewDevice("iPhone 12")
    }
}



