//
//  SettingsModels.swift
//  MusicPlayer
//
//  Created by  User on 08.04.2023.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
