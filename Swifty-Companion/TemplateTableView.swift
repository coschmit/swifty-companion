//
//  TemplateTableRow.swift
//  Swifty-Companion
//
//  Created by Colin Schmitt on 31/01/2021.
//

import SwiftUI

struct TemplateTableView: View {
    
    var title : String
    var data: [UserData]
    
    var body: some View {
        ZStack {
            Color("Background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack (alignment: .leading,spacing: 2){
                Text(title)
                    .font(.largeTitle).fontWeight(.semibold)
                List {
                    ForEach(data,id: \.id){
                        dataRow in
                        
                       TemplateTableRow(data: dataRow)
                        
                    }
                }.listRowBackground(Color("Background")).onAppear(){
                    UITableView.appearance().backgroundColor = UIColor(named: "Background")
                    UITableView.appearance().separatorColor = UIColor(named: "ShadowPP")
                    UITableView.appearance().separatorStyle = .singleLine
                }.frame(minHeight: 250, maxHeight: 500)
            }.padding()
        }
        
    }
}

struct TemplateTableView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateTableView(title: "Projects", data: [UserData]())
            .preferredColorScheme(.dark)
            
            
    }
}
