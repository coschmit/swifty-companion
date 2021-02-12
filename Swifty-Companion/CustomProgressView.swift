//
//  CustomProgressView.swift
//  Swifty-Companion
//
//  Created by Colin Schmitt on 29/01/2021.
//

import SwiftUI

struct CustomProgressView: View {
    
    @Binding var percent: CGFloat
    
    var body: some View {
        ZStack(alignment:.leading) {
            
            ZStack(alignment:.trailing){
                Capsule().fill(Color.black.opacity(0.08)).frame(height:20)
                
                Text(String(format: "%.0f",  self.percent * 100) + "%").font(.caption).foregroundColor(Color.gray.opacity(0.75)).padding(.trailing)
            }
            
            Capsule().fill(LinearGradient(gradient: .init(colors: [Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)),Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)).frame(width:self.calcPercent(),height:20)
        }.padding(18).background(Color.black.opacity(0.085)).cornerRadius(15)
    }
    
    func calcPercent()->CGFloat{
        let width = UIScreen.main.bounds.width - 36
        
        return width * self.percent
    }
}

//struct CustomProgressView_Previews: PreviewProvider {
//    
//    
//    static var previews: some View {
//        
//        
//        CustomProgressView()
//    }
//}
