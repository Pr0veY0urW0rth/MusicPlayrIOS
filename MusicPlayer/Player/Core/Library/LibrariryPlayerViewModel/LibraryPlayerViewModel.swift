//
//  LibraryPlayerViewModel.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 18.12.2022.
//

import UIKit

final class LibraryPlayerViewModel{
    
    private var numberOfSec: Int = 3
    var AlbumSource: [Album] = []
    var ArtistSource: [Artist] = []
    var PlaylistSource: [Playlist] = []
    
    
    func numberOfSections() -> Int{
        return numberOfSec
    }

    func fetchData(collection: UICollectionView){
        fetchArtists(collection: collection)
        fetchAlbums(collection: collection)
        fetchPlaylists(collection: collection)
    }
    
    private func fetchArtists(collection: UICollectionView){
        SpotifyAPICaller.shared.getCurrentUserArtists{
            result in
                switch result {
                case .success(let model):
                    model.artists.items.forEach{
                        artist in
                        self.ArtistSource.append(artist)
                    }
                    DispatchQueue.main.async {
                        collection.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    private func fetchAlbums(collection: UICollectionView){
        SpotifyAPICaller.shared.getCurrentUserAlbums{ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let albums):
                    albums.forEach{
                        item in
                        self!.AlbumSource.append(item)
                    }
                    collection.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchPlaylists(collection: UICollectionView){
        SpotifyAPICaller.shared.getCurrentUserPlaylists{result in
            switch result {
            case .success(let model):
                model.forEach{ playlist in
                    self.PlaylistSource.append(playlist)
                }
                DispatchQueue.main.async {
                    collection.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)

            }
        }
    }
}
