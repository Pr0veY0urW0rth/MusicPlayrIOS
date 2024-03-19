//
//  SettingsViewModel.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit

struct settingsCells{
    var username: TextCellState
    var email: TextCellState
    var password: TextCellState
    var secondPassword: TextCellState
}

final class SettingsViewModel{
    
    func cellState(type: CellType) -> State{
        return .valid
    }
    
    func cellText(type: CellType) -> String{
        return ""
    }
}
