//
//  PlaylistViewModel.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit

final class PlaylistViewModel{
    private var id: String
    private var playlistTitle: String
    private var desc: String
    private var image : String?
    
    private var tracks: [Track] = []
    
    init(playlistId: String, playlistTitle: String, playlistDesc: String) {
        self.id = playlistId
        self.playlistTitle = playlistTitle
        self.desc = playlistDesc
    }
    
    func getPlaylistTitle() -> String{
        return self.playlistTitle
    }
    
    func getPlaylistDescription() -> String{
        return self.desc
    }
    
    func getCover() -> String{
        return image ?? Images.trackPlaceholder
    }
    
    func getData() -> [Track]{
        return tracks
    }

  func fetchData(table: UITableView){
      SpotifyAPICaller.shared.getPlaylistDetails(for: self.id) { [weak self] result in
          DispatchQueue.main.async {
              switch result {
              case .success(let model):
                  model.tracks.items.forEach{ track in
                      self?.tracks.append(track.track)
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
