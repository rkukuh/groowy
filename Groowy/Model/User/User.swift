//
//  User.swift
//  Groowy
//
//  Created by David-UC on 2/12/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation

enum UserRole {
    case mentor
    case mentee
}

enum UserState {
    case introduction
    case deepUnderstanding
    case gift
    case dashboard
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
    
    static var role: UserRole {
        get {
            return userDefault.value(forKey: "role") as? UserRole ?? .mentee
        }
        set {
            userDefault.set(newValue, forKey: "role")
        }
    }
    
    static var state: UserState {
        get {
            return userDefault.value(forKey: "userState") as? UserState ?? .introduction
        }
        set {
            userDefault.set(newValue, forKey: "userState")
        }
    }
}
