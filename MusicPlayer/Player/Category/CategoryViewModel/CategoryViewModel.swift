//
//  CategoryViewModel.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit

final class CategoryViewModel{
    private var id: String
    private var title: String
    private var playlists: [Playlist] = []
    
    init(categoryID: String, categoryTitle: String) {
        self.id = categoryID
        self.title = categoryTitle
    }
    
    func getData() -> [Playlist]{
        return playlists
    }

    func fetchData(collection: UICollectionView){
        SpotifyAPICaller.shared.getCategoryPlaylists(categoryID: self.id){ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    playlists.forEach{ playlist in
                        self?.playlists.append(playlist)
                    }
                    collection.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
//    func fetchData(collection: UICollectionView){
//        SpotifyAPICaller.shared.getNewReleases{ [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let albums):
//                    albums.albums.items.forEach{
//                        item in
//                        let al = AlbumViewData(id: item.id, title: item.name, Author: item.artists.first?.name ?? "-", previewImage: item.images.first?.url ?? "placeholder", fullImage: item.images.first?.url ?? "placeholder")
//                        self!.AlbumSource.append(al)
//                    }
//                    collection.reloadData()
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
}
