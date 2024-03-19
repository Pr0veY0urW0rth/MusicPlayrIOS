//
//  ArtistViewModel.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 08.01.2023.
//

import UIKit

final class ArtistViewModel{
    private var id: String
    private var ArtistName: String
    private var cover: String?
    private var numberOfSec: Int = 3
    var AlbumSource: [Album] = []
    var TrackSource: [Track] = []
    
    init(artistID: String, ArtistTitle: String) {
        self.id = artistID
        self.ArtistName = ArtistTitle
    }
    
    func numberOfSections() -> Int{
        return numberOfSec
    }
    func getArtistName() -> String{
        return self.ArtistName
    }
    
    func fetchData(collection: UICollectionView){
        getArtistCover()
        getAlbums(collection: collection)
        //getPopularArtistTracks(collection: collection)
    }
    
    func getCover() -> String{
        return cover ?? Images.trackPlaceholder
    }
    
    func getAlbums(collection: UICollectionView){
        SpotifyAPICaller.shared.getArtistsAlbums(id: self.id){[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self!.AlbumSource += model
                    collection.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getPopularArtistTracks(collection: UICollectionView){
        SpotifyAPICaller.shared.getArtistsTracks(id: self.id){[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    //self!.TrackSource += model
                    print(model)
                    collection.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getArtistCover(){
        SpotifyAPICaller.shared.getArtist(id: self.id){[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self!.cover = model.images?.first?.url
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

