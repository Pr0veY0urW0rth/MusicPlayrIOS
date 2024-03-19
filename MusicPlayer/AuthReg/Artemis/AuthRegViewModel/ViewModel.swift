//
//  ViewModel.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 01.11.2022.
//

import Foundation
import UIKit


struct Validator{
    var succes: Bool
    var alertTitle: String
    var alert: String
}

enum State{
    case invalid
    case valid
}

struct TextCellState{
    var text: String
    var state: State
}

struct AuthCells{
    var username: TextCellState
    var email: TextCellState
    var password: TextCellState
    var secondPassword: TextCellState
}

protocol AuthViewModelProtocol{
    func Update(mode: AuthMode,type: CellType,text: String)
    func validate(mode: AuthMode) -> Validator
}

final class AuthViewModel: AuthViewModelProtocol{
    //Mark: - stored properties
    private var registerCells: AuthCells = AuthCells(username: TextCellState(text: "", state: .valid), email: TextCellState(text: "", state: .valid), password: TextCellState(text: "", state: .valid), secondPassword: TextCellState(text: "", state: .valid))
    
    func validate(mode: AuthMode) -> Validator {
        switch mode{
        case .signUpMode:
            if(!AuthValidator.isValidLogin(registerCells.username.text)){
                registerCells.username.state = .invalid
                return Validator(succes: false, alertTitle: AuthStrings.invalidUsernameTitle, alert: AuthStrings.invalidUsername)
           }
            else if(!AuthValidator.isValidEmail(registerCells.email.text)){
                registerCells.email.state = .invalid
                return Validator(succes: false, alertTitle: AuthStrings.invalidEmailTitle, alert: AuthStrings.invalidEmail)
           }
            else if(!AuthValidator.isValidPassword(registerCells.password.text)){
                registerCells.password.state = .invalid
            return Validator(succes: false, alertTitle: AuthStrings.invalidFirstPasTitle, alert: AuthStrings.invalidFirstPas)
           }
            else if(registerCells.password.text != registerCells.secondPassword.text)
           {
                registerCells.secondPassword.state = .invalid
            return Validator(succes: false, alertTitle: AuthStrings.invalidSecondPasTitle, alert: AuthStrings.invalidSecondPas)
           }
           else{
               LoginManager.shared.addUser(user: UserDTO(username: registerCells.username.text, email: registerCells.email.text, password: registerCells.password.text))
               UserManager.login = registerCells.username.text
               UserManager.email = registerCells.email.text
               UserManager.password = registerCells.password.text
               UserManager.isLoggedIn = true
            return Validator(succes: true, alertTitle: AuthStrings.regCompleteTitle, alert: AuthStrings.regComplete)
           }
        case .signInMode:
            if(LoginManager.shared.getIfUserExists(username: registerCells.username.text)) {
                let data = LoginManager.shared.getUserDetails(username: registerCells.username.text)
                if(data.password == registerCells.password.text){
                    UserManager.login = registerCells.username.text
                    UserManager.password = registerCells.password.text
                    UserManager.email = registerCells.email.text
                    UserManager.isLoggedIn = true
                }
                return Validator(succes: true, alertTitle: "", alert: "")
            }
            break
        }
        return Validator(succes: false, alertTitle: AuthStrings.loginFailed, alert: AuthStrings.invalidlogin)
    }
    
    //Выделение метода
    func Update(mode: AuthMode,type: CellType,text: String) {
        if mode == .signUpMode{
            switch type{
            case .login:
                registerCells.username = UpdateCellState(text)
            case .email:
                registerCells.email =  UpdateCellState(text)
            case .password:
                registerCells.password = UpdateCellState(text)
            case .repeatPassword:
                registerCells.secondPassword = UpdateCellState(text)
            default: break;
            }
        }
        else{
            switch type{
            case .login:
                registerCells.username = UpdateCellState(text)
            case .password:
                registerCells.password = UpdateCellState(text)
            default: break;
            }
        }
    }
    
    func GetCellState(type: CellType) -> State{
        switch type{
        case .login:
            return registerCells.username.state
        case .email:
            return registerCells.email.state
        case .password:
            return registerCells.password.state
        case .repeatPassword:
            return registerCells.secondPassword.state
        default: return .valid
        }
    }
    
    func GetCellText(type: CellType) -> String{
        switch type{
        case .login:
            return registerCells.username.text
        case .email:
            return registerCells.email.text
        case .password:
            return registerCells.password.text
        case .repeatPassword:
            return registerCells.secondPassword.text
        default: return ""
        }
    }
    
    func ClearCells(){
        registerCells = AuthCells(username: CreateTextCell(), email: CreateTextCell(), password: CreateTextCell(), secondPassword: CreateTextCell())
    }

    //Выделение методов
    func UpdateCellState(text:String) -> TextCellState{
        state = TextCellState(text: text, state: .valid)
        return state
    }

    func CreateTextCell() -> TextCellState{
        return TextCellState(text:"",state:.valid)
    }
}
