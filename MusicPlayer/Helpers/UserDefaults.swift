//
//  UserDefaults.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 12.11.2022.
//

import Foundation
import UIKit

struct UserDTO{
    var username: String
    var email: String
    var password: String
}

class UserManager: NSObject {
    
    static var isLoggedIn: Bool  {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isLoggedIn)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.isLoggedIn)
            UserDefaults.standard.synchronize()
        }
    }
    
    // Username (Login)
    static var login: String  {
        get {
            return UserDefaults.standard.string(forKey: Keys.username)!
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.username)
        }
    }
    
    // E-mail
    static var email: String  {
        get {
            return UserDefaults.standard.string(forKey: Keys.email)!
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.email)
        }
    }
    
    // Password
    static var password: String  {
        get {
            return UserDefaults.standard.string(forKey: Keys.password)!
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.password)
        }
    }
    
    
}

final class LoginManager{
    
    static let shared = LoginManager()
    
    func addUser(user: UserDTO){
        var userDict: [String:Any] = [:]
        userDict = [
            Keys.email: user.email,
            Keys.password: user.password
        ]
        UserDefaults.standard.set(userDict,forKey: user.username)
    }
    func getIfUserExists(username: String) -> Bool{
        let userDict = UserDefaults.standard.dictionary(forKey: username)
        if(userDict != nil){return true}
        else {return false}
    }
    
    func getUserDetails(username: String) -> UserDTO{
        let userDict = UserDefaults.standard.dictionary(forKey: username)
        return UserDTO(username: username, email: userDict![Keys.email] as! String, password: userDict![Keys.password] as! String)
    }
}
