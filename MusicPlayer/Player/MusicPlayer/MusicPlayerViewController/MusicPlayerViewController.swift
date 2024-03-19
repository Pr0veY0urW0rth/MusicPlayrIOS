//
//  MusicPlayerViewController.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 06.01.2023.
//

import UIKit

final class MusicPlayerViewController:  UIViewController{
    
    private let viewModel: MusicPlayerViewModel
    
    private let cover: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .artemisBackground
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Images.trackPlaceholder)
        imageView.layer.cornerRadius = 15
        imageView.layer.borderColor = UIColor.artemisButtonBackground.cgColor
        imageView.layer.borderWidth = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let controlView = PlayerControlView()
    
    init(trackID: String, trackTitle: String?, trackAuthor: String?,audio: URL?) {
        let title: String = trackTitle ?? ""
        let author: String = trackAuthor ?? ""
        self.viewModel = MusicPlayerViewModel(trackID: trackID, trackTitle: title, trackAuthor: author,audio: audio)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .artemisBackground
        view.addSubview(cover)
        view.addSubview(controlView)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        controlView.delegate = self
        layout()
        configure()
        viewModel.startPlayback()
    }
    
    private func layout(){
        
        cover.translatesAutoresizingMaskIntoConstraints = false
        controlView.translatesAutoresizingMaskIntoConstraints = false
        
        cover.topAnchor.constraint(equalTo: view.topAnchor,constant: 170).isActive = true
        cover.widthAnchor.constraint(equalToConstant: 270).isActive = true
        cover.heightAnchor.constraint(equalToConstant: 270).isActive = true
        cover.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        controlView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        controlView.topAnchor.constraint(equalTo: view.centerYAnchor,constant: 50).isActive = true
        controlView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        controlView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 10).isActive = true
    }
    
    private func configure(){
        controlView.configure(model: PlayerControlViewModel(title: viewModel.getTrackTitle(), author: viewModel.getTrackAuthor(),totalTime: viewModel.getTotalTime()))
    }
}

extension MusicPlayerViewController: PlayerControlViewDelegate{
    func playerControlViewDidTapMoreButtin(_ playerControlView: PlayerControlView) {
    }
    
    func playerControlViewDidTapPlayPauseButton(_ playerControlView: PlayerControlView) {
        viewModel.didTapPlayPause()
    }
    
    func playerControlViewDidTapForwardButton(_ playerControlView: PlayerControlView) {
        viewModel.didTapForward()
    }
    
    func playerControlViewDidTapBackwardsButton(_ playerControlView: PlayerControlView) {
        viewModel.didTapBackward()
    }
    
    func playerControlViewDidTapMixButton(_ playerControlView: PlayerControlView) {
        
    }
    
    func playerControlViewDidTapRepeatButton(_ playerControlView: PlayerControlView) {
        
    }
    
    func playerControlViewDidTapLikeButton(_ playerControlView: PlayerControlView) {
        
    }
    
    func playerControlView(_ playerControlView: PlayerControlView, didSlideSlider value: Float) {
        
    }
}
