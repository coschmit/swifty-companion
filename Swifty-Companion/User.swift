//
//  Profile.swift
//  Swifty-Companion
//
//  Created by Colin Schmitt on 28/01/2021.
//

import Combine
import SwiftUI

struct UserData {
    
    var id: Int
    var name: String
    var state: String
    var grade: NSNumber
    var validated: Bool
    
    init() {
        self.id = 0
        self.name = "default"
        self.state = "default"
        self.grade = NSNumber(0)
        self.validated = false
    }
    
    init(id: Int,name: String,state: String,grade: NSNumber,validated: Bool){
        self.id = id
        self.name = name
        self.state = state
        self.grade = grade
        self.validated = validated
    }
}

class User : ObservableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    
    @Published var isActive : Bool = false {didSet {didChange.send()}}
    var login : String = "default" {didSet {didChange.send()}}
    var email : String = "default@student.42.fr" {didSet {didChange.send()}}
    var phone : String = "0611223344" {didSet{didChange.send()}}
    var location: String = "Unavailable" { didSet { didChange.send() } }
    var displayName: String = "Default Name" { didSet { didChange.send() } }
    var level: Float = 0 { didSet { didChange.send() } }
    var image: Image = Image("pp") { didSet { didChange.send() } }
    
    var projects: [UserData] = [UserData]() { didSet { didChange.send() } }
    var skills: [UserData] = [UserData]() { didSet { didChange.send() } }
}
