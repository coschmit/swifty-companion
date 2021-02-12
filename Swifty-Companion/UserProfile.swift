//
//  UserProfile.swift
//  Swifty-Companion
//
//  Created by Colin Schmitt on 29/01/2021.
//

import SwiftUI

struct UserProfile: View {
    
    var user : User
    
    var body: some View {
        VStack{
            HStack(alignment:.center, spacing: 18) {
                UserPicture(image: self.user.image,width: 100)
                VStack(alignment: .leading) {
                    Text("@\(user.login)").font(    .title).fontWeight(.semibold)
                    Text(user.displayName)
                    Text(user.email).font(.headline)
                    Text(user.location).font(.subheadline)
                }
            }
            
            let lvlPercent = modf(user.level).1 * 100
            ProgressView("Level: \(Int(user.level)) - \(Int(lvlPercent))%",value: Float(lvlPercent),total: 100).padding(.horizontal,30).padding(.top,20).progressViewStyle(LinearProgressViewStyle(tint: Color(#colorLiteral(red: 0.420615579, green: 0.8792231553, blue: 0.6101900477, alpha: 1))))

            
        }.padding().onAppear(){
            
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(user: User())
    }
}
