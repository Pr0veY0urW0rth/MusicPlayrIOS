//
//  PlaylistHeader.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit
import SDWebImage

protocol PlaylistHeaderDelegate: HeaderDelegate{
    func playerControlViewDidTapPlayPauseButton(_ playlistHeader: PlaylistHeader)
    func playerControlViewDidTapMixButton(_ playlistHeader: PlaylistHeader)
    func playerControlViewDidTapLikeButton(_ playlistHeader: PlaylistHeader)
}

struct PlaylistHeaderModel{
    let title: String
    let desc: String
    let cover: String
}

final class PlaylistHeader: UIView{
    
    weak var delegate: PlaylistHeaderDelegate?
    
    private var isPlaying = false
    private var isMixed = false
    private var isLiked = false
    
    private let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont(name: FontTypes.poppinsBold, size: 28)
        return label
    }()
    
    private let cover: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    private let desc: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        return label
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
    
    private let mixBtn: UIButton = {
        let btn = UIButton()
        btn.tintColor = .black
        btn.backgroundColor = .clear
        let image = UIImage(systemName: Images.mix ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        btn.setImage(image, for: .normal)
        btn.setImage(image, for: .selected)
        return btn
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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
        setUpTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        let buttonSize = 75.0
        
        let views: [UIView] = [cover,title,desc,likeBtn,mixBtn,playPauseBtn]
        views.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cover.topAnchor.constraint(equalTo: topAnchor),
            cover.centerXAnchor.constraint(equalTo: centerXAnchor),
            cover.widthAnchor.constraint(equalToConstant: 150),
            cover.heightAnchor.constraint(equalToConstant: 150),
            
            title.topAnchor.constraint(equalTo: cover.bottomAnchor,constant: 20),
            title.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            title.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 10),
            
            desc.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 10),
            desc.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            desc.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            
            likeBtn.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            likeBtn.widthAnchor.constraint(equalToConstant: buttonSize),
            likeBtn.heightAnchor.constraint(equalToConstant: buttonSize),
            likeBtn.topAnchor.constraint(equalTo: desc.bottomAnchor,constant: 5),
            
            playPauseBtn.topAnchor.constraint(equalTo: desc.bottomAnchor,constant: 5),
            playPauseBtn.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            playPauseBtn.widthAnchor.constraint(equalToConstant: buttonSize),
            playPauseBtn.heightAnchor.constraint(equalToConstant: buttonSize),
            
            
            mixBtn.topAnchor.constraint(equalTo: desc.bottomAnchor,constant: 5),
            mixBtn.trailingAnchor.constraint(equalTo: playPauseBtn.leadingAnchor),
            mixBtn.widthAnchor.constraint(equalToConstant: buttonSize),
            mixBtn.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
    }
    
    func configure(header: PlaylistHeaderModel){
        title.text = header.title
        
        //cover.image = UIImage(named: header.cover) ?? UIImage(named: Images.trackPlaceholder)!
        cover.sd_setImage(with: URL(string: header.cover), completed: nil)
        desc.text = header.desc
    }
    
    @objc private func didTapPlayPause(){
        self.isPlaying = !isPlaying
        playPauseBtn.isSelected = isPlaying
        delegate?.playerControlViewDidTapPlayPauseButton(self)
    }
    
    @objc private func didTapMix(){
        self.isMixed = !isMixed
        mixBtn.isSelected = isMixed
        if(mixBtn.isSelected){
            mixBtn.tintColor = .spotifyGreen
        }
        else{
            mixBtn.tintColor = .black
        }
        delegate?.playerControlViewDidTapMixButton(self)
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
        delegate?.playerControlViewDidTapLikeButton(self)
    }
    
    private func setUpTargets(){
        playPauseBtn.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        mixBtn.addTarget(self, action: #selector(didTapMix), for: .touchUpInside)
        likeBtn.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
    }
}

extension PlaylistHeader: Header{
    func setUpDelegate(delegate: HeaderDelegate) {
        self.delegate = delegate as? any PlaylistHeaderDelegate
    }
}
