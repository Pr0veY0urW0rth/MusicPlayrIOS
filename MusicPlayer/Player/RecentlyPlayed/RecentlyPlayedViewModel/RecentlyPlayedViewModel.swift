//
//  RecentlyPlayedViewModel.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit

final class RecentlyPlayedViewModel{
    private var tracks: [Track] = []
    
    func getData() -> [Track]{
        return tracks
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
