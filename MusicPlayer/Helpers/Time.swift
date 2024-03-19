//
//  Time.swift
//  MusicPlayer
//
//  Created by  User on 09.04.2023.
//

import Foundation

func secondsToString(_ time: Double) -> String{
    let seconds = Int(time.truncatingRemainder(dividingBy: 60))
    let minutes = Int(time/60)
    let str = "\(minutes):\(seconds)"
    return str
}
