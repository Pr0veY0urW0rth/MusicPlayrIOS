//
//  PlayerHomeViewModel.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 14.12.2022.
//

import UIKit

final class HomePlayerViewModel{
    
    private var numberOfSec: Int = 5

    var AlbumSource: [Album] = []
    var ArtistSource: [Artist] = []
    var PlaylistSource: [Playlist] = []
    var TrackSource: [Track] = []
    
    func numberOfSections() -> Int{
        return numberOfSec
    }
    
    func fetchData(collection: UICollectionView){
        fetchArtists(collection: collection)
        fetchAlbums(collection: collection)
        fetchTracks(collection: collection)
        fetchPlaylists(collection: collection)
    }
    
    private func fetchAlbums(collection: UICollectionView){
        SpotifyAPICaller.shared.getNewReleases{ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let albums):
                    albums.albums.items.forEach{
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
    
    private func fetchArtists(collection: UICollectionView){
        let group = DispatchGroup()
        group.enter()
        
        SpotifyAPICaller.shared.getCurrentUserArtists{ result in
            switch result {
            case .success(let model):
                let artists = model
                let seeds: Artist = artists.artists.items.randomElement()!
                
                SpotifyAPICaller.shared.getRecomendedArtists(for: seeds){recommendedResult in
                    switch recommendedResult {
                    case .success(let model):
                        model.artists.forEach{
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

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchTracks(collection: UICollectionView){
            let group = DispatchGroup()
            group.enter()
        
        SpotifyAPICaller.shared.gerRecommendedGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }

                SpotifyAPICaller.shared.getRecommendations(genres: seeds) { [self] recommendedResult in
                    switch recommendedResult {
                    case .success(let model):
                        model.tracks.forEach{
                            track in
                            self.TrackSource.append(track)
                        }
                        DispatchQueue.main.async {
                            collection.reloadData()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchPlaylists(collection: UICollectionView){
        SpotifyAPICaller.shared.getFeaturedPlaylists{result in
            switch result {
            case .success(let model):
                model.playlists.items.forEach{ playlist in
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
