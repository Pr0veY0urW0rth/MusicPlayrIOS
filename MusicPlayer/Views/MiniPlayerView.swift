//
//  MiniPlayerView.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 08.01.2023.
//

import UIKit

protocol MiniPlayerViewDelegate: AnyObject{
    func didTapPlayPause(_ miniplayer: MiniPlayerView)
    func didTapLike(_ miniplayer: MiniPlayerView)
}

class MiniPlayerView: UIView {
    
    private var isPlaying: Bool = false
    private var isLiked: Bool = false
    
    weak var delegate: MiniPlayerViewDelegate?
    
    private let trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let trackTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    private let playPauseBtn: UIButton = {
        let btn = UIButton()
        btn.tintColor = .black
        btn.backgroundColor = .clear
        let image = UIImage(systemName: Images.isPaused,withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        btn.setImage(image, for: .normal)
        let imageSelected = UIImage(systemName: Images.isPlaying, withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        btn.setImage(imageSelected, for: .selected)
        return btn
    }()
    
    private let likeBtn: UIButton = {
        let btn = UIButton()
        btn.tintColor = .black
        btn.backgroundColor = .clear
        let image = UIImage(systemName: Images.isNotLiked ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        btn.setImage(image, for: .normal)
        let imageSelected = UIImage(systemName: Images.isLiked, withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        btn.setImage(imageSelected, for: .selected)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTargets()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(trackName: String, artist: String, isPlaying: Bool, isLiked: Bool, imagePath: String){
        self.trackTitleLabel.text = trackName
        self.artistNameLabel.text = artist
        self.isPlaying = isPlaying
        self.isLiked = isLiked
        let image = UIImage(named: imagePath) ?? UIImage(named: Images.trackPlaceholder)
        self.trackImageView.image = image
    }
    
    @objc private func didTapPlayPause(){
        self.isPlaying = !isPlaying
        playPauseBtn.isSelected = isPlaying
        delegate?.didTapPlayPause(self)
    }
    
    @objc private func didTapLike(){
        self.isLiked = !isLiked
        likeBtn.isSelected = isLiked
        if(likeBtn.isSelected){
            likeBtn.tintColor = .spotifyGreen
        }
        else{
            likeBtn.tintColor = .black
        }
        delegate?.didTapLike(self)
    }
    
    private func setUpTargets(){
        playPauseBtn.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        likeBtn.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
    }
    
    private func setupView() {
        backgroundColor = .artemisBackground
        
        let stackView = UIStackView.makeStackView(axis: .vertical)
        stackView.spacing = 6
        stackView.addArrangedSubview(trackTitleLabel)
        stackView.addArrangedSubview(artistNameLabel)
        
        addSubview(trackImageView)
        addSubview(stackView)
        addSubview(likeBtn)
        addSubview(playPauseBtn)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            trackImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            trackImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            trackImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            trackImageView.widthAnchor.constraint(equalTo: trackImageView.heightAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            stackView.widthAnchor.constraint(equalTo: stackView.heightAnchor),
            
            
            likeBtn.trailingAnchor.constraint(equalTo: playPauseBtn.leadingAnchor,constant: -padding),
            likeBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            likeBtn.widthAnchor.constraint(equalToConstant: 44),
            likeBtn.heightAnchor.constraint(equalToConstant: 44),
            
            playPauseBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            playPauseBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            playPauseBtn.widthAnchor.constraint(equalToConstant: 44),
            playPauseBtn.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

