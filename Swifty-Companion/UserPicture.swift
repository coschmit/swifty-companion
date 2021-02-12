//
//  UserPicturre.swift
//  Swifty-Companion
//
//  Created by Colin Schmitt on 29/01/2021.
//

import SwiftUI

struct UserPicture: View {
    
    var image : Image
    var width: CGFloat = 130
    var body: some View {
        self.image.resizable().aspectRatio(contentMode: .fill).frame(width:self.width,height:self.width).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).overlay(Circle().stroke(Color("CirclePP"),lineWidth: 4)).shadow(color: Color("ShadowPP"), radius: 4)
    }
}
