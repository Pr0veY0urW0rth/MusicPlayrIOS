//
//  SearchResult.swift
//  MusicPlayer
//
//  Created by  User on 08.04.2023.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: Track)
    case playlist(model: Playlist)
}
