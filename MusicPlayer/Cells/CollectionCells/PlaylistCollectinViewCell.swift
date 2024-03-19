//
//  PlaylistCollectinViewCell.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 18.12.2022.
//
import UIKit
import SDWebImage

protocol PlaylistCVDelegate: PlayerItemsDelegate{
    func cellTapped(_ model: Playlist)
}

final class PlaylistCollectionViewCell: UICollectionViewCell{
    private var id: String = ""
    
    weak var delegate: PlaylistCVDelegate?
    
    private let title:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontTypes.poppins, size: 22)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private let desc:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontTypes.poppins, size: 24)
        label.textColor = .black
        label.text = ""
        return label
    }()
    
    private let previewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let fullImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var model: Playlist?
    
    func modelProperty() -> Playlist{
        return self.model!
    }
    
    func configure(playlist: Playlist){
        self.id = playlist.id
        title.text = playlist.name
        desc.text = playlist.description
        previewImage.sd_setImage(with: URL(string: playlist.images.first?.url ?? Images.trackPlaceholder), completed: nil)
        fullImage.sd_setImage(with: URL(string: playlist.images.first?.url ?? Images.trackPlaceholder), completed: nil)
        self.model = playlist
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playlistTapped))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    
    @objc private func playlistTapped(){
        delegate?.cellTapped(self.model!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Errors.fatalError)
    }
    
    private func layout(){
        let views: [UIView] = [title,previewImage]
        views.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            previewImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            previewImage.heightAnchor.constraint(equalToConstant: 120),
            previewImage.widthAnchor.constraint(equalToConstant: 120),
            
            title.topAnchor.constraint(equalToSystemSpacingBelow: previewImage.bottomAnchor, multiplier: 2),
            title.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            title.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension PlaylistCollectionViewCell: PlayerItem{
    func setUpDelegate(delegate: PlayerItemsDelegate) {
        self.delegate = delegate as? any PlaylistCVDelegate
    }
}
