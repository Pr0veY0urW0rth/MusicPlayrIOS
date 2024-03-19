//
//  MusicPlayerViewModel.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit
import AVFoundation

final class MusicPlayerViewModel{
    private var track: [Track] = []
    private var audio: URL?
    private var index = 0
    private var isPlaying: Bool = false
    private var player: AVPlayer?
    
    private var trackID: String
    private var trackTitle: String
    private var trackAuthor: String
    
    init(trackID: String, trackTitle: String, trackAuthor: String,audio: URL?) {
        self.trackID = trackID
        self.trackTitle = trackTitle
        self.trackAuthor = trackAuthor
        self.audio = audio
    }
    
    func getTrackTitle() -> String{
        return trackTitle
    }
    
    func getTrackAuthor() -> String{
        return trackAuthor
    }
    
    func getTotalTime() -> Int{
        return 10
    }
    
    func startPlayback(){
        do {
            let playerItem = AVPlayerItem(url: self.audio!)
            
            self.player = try AVPlayer(playerItem:playerItem)
            player!.volume = 1.0
            self.isPlaying = true
            player?.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
    func didTapPlayPause(){
        switch isPlaying{
        case true:
            player?.pause()
            isPlaying = false
        case false:
            player?.play()
            isPlaying = true
        }
    }
    
    func didTapForward() {
        player?.pause()
    }
    
    func didTapBackward() {
        player?.pause()
        player?.play()
    }
    
    func getCurrentTime() -> Double{
        return CMTimeGetSeconds((player?.currentTime())!)
    }
    
    func fetchData(collection: UICollectionView){
        
    }
    
}

