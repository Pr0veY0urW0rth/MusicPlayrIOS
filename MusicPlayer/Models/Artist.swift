//
//  Artist.swift
//  MusicPlayer
//
//  Created by  User on 08.04.2023.
//

import Foundation

struct PopularArtistsTracks:Codable{
    let items: [Track]
}

struct ArtistAlbums: Codable{
    let items: [Album]
}

struct ArtistsResponse: Codable{
    let artists: ArtistsItems
}

struct ArtistsItems: Codable{
    let items: [Artist]
}

struct recomendedArtistsResponse: Codable{
    let artists: [Artist]
}

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
}
