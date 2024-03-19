//
//  LibraryAlbums.swift
//  MusicPlayer
//
//  Created by  User on 08.04.2023.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
