//
//  SearchPlayerViewModel.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 04.01.2023.
//

import Foundation
import UIKit

final class SearchPlayerViewModel{
    
    private var categories: [Category] = []
    
    
    func countCategories() -> Int{
        return categories.count
    }
    
    func data() -> [Category]{
        return categories
    }
    
    func fetchData(collection: UICollectionView){
        SpotifyAPICaller.shared.getCategories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    categories.forEach{ categorie in
                        self?.categories.append(categorie)
                    }
                    collection.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
