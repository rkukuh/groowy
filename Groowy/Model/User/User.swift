//
//  User.swift
//  Groowy
//
//  Created by David-UC on 2/12/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation

enum UserRole: String {
    case mentor = "Mentor"
    case mentee = "Mentee"
}

enum UserState: String {
    case introduction = "introduction"
    case deepUnderstanding = "deepUnderstanding"
    case gift = "gift"
    case dashboard = "dashboard"
}

class User {
    static private let userDefault = UserDefaults.standard
    static var name: String {
        get {
            return userDefault.value(forKey: "name") as? String ?? ""
        }
        set {
            userDefault.set(newValue, forKey: "name")
        }
    }
    
    static var role: String {
        get {
            return userDefault.value(forKey: "role") as? String ?? UserRole.mentee.rawValue
        }
        set {
            userDefault.set(newValue, forKey: "role")
        }
    }
    static var state: String {
        get {
            return userDefault.value(forKey: "userState") as? String ?? UserState.introduction.rawValue
        }
        set {
            userDefault.set(newValue, forKey: "userState")
        }
    }
    static var email: String {
        get {
            return userDefault.value(forKey: "email") as? String ?? ""
        }
        set {
            userDefault.set(newValue, forKey: "email")
        }
    }
}
