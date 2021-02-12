//
//  ContentView.swift
//  Swifty-Companion
//
//  Created by Colin Schmitt on 24/01/2021.
//

import SwiftUI
import Alamofire





struct ContentView: View {
        
    var auth = Auth()
    let url = "https://schmittcolin.com/img/landscape/IMG_3299%20-%20Website.jpg"
    
    
    var body: some View {
        
        NavigationView {
            SearchView(auth: auth).navigationBarTitle("Search",displayMode: .large).environmentObject(User())
           
        }.onAppear{
            fetch()
        }
    }
    
    
    private func fetch() {
        auth.getToken()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
