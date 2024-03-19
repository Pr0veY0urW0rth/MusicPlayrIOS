//
//  Validation.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 10.11.2022.
//


import Foundation

class AuthValidator{
    static func isValidLogin(_ login: String) -> Bool {
        let loginRegEx = "^[A-Za-z0-9]{8,32}$"
        let loginpred = NSPredicate(format: "SELF MATCHES %@", loginRegEx)
        return loginpred.evaluate(with: login)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        let passRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,16}$"
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: password)
    }
}
