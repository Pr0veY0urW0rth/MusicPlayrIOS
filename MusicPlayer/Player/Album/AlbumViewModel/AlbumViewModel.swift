//
//  AlbumViewModel.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit

final class AlbumViewModel{
    private var id: String
    private var albumTitle: String
    private var author: String
    private var image: String?
    
    private var tracks: [Track] = []
    
    init(albumId: String, albumTitle: String, albumAuthor: String) {
        self.id = albumId
        self.albumTitle = albumTitle
        self.author = albumAuthor
    }
    
    func getAlbumTitle() -> String{
        return self.albumTitle
    }
    
    func getAlbumAuthor() -> String{
        return self.author
    }
    
    func getCover() -> String{
        return image ?? Images.trackPlaceholder
    }
    
    func getData() -> [Track]{
        return tracks
    }

    func fetchData(table: UITableView){
        SpotifyAPICaller.shared.getAlbumDetails(for: self.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    let a = Album(album_type: model.album_type, available_markets: model.available_markets, id: model.id, images: model.images, name: model.name, release_date: "", total_tracks: model.tracks.items.count, artists: model.artists)
                    model.tracks.items.forEach{ track in
                        var t = track
                        t.album = a
                        self?.tracks.append(t)
                    }
                    self?.image = model.images.first?.url
                    table.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
