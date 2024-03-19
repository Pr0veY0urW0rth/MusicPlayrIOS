//
//  Track.swift
//  MusicPlayer
//
//  Created by  User on 08.04.2023.
//

import Foundation

struct Track: Codable {
    var album: Album?
    let artists: [Artist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id: String
    let name: String
    let preview_url: String?
}
