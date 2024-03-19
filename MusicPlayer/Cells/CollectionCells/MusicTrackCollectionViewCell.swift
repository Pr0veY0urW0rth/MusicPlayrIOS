//
//  PlayableItemTableViewCell.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 06.12.2022.
//

import SDWebImage
import UIKit

protocol MusicTrackCVDelegate: PlayerItemsDelegate{
    func cellTapped(_ model: Track)
}

final class MusicTrackCollectionViewCell: UICollectionViewCell{
    private let trackCellHeight: CGFloat = 64
    
    weak var delegate: MusicTrackCVDelegate?
    
    private var id: String = ""
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontTypes.poppins, size: 24)
        label.textColor = .black
        return label
    }()
    
    private let author: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontTypes.poppinsLight, size: 20)
        label.textColor = .black
        label.alpha = 0.7
        return label
    }()
    
    private var duration: Int = 0
    
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
    
    private var audio: URL? = URL(string: "")
    
    private var model_ : Track?
    
    func modelProperty() -> Track{
        return self.model_!
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Errors.fatalError)
    }
    
    func configure(track: Track){
        id = track.id
        previewImage.sd_setImage(with: URL(string: track.album?.images.first?.url ?? ""), completed: nil)
        fullImage.sd_setImage(with: URL(string: track.album?.images.first?.url ?? ""), completed: nil)
        title.text = track.name
        author.text = track.artists[0].name
        duration = track.duration_ms
        audio = URL(string: track.preview_url ?? "")
        self.model_ = track
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(trackTapped))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func trackTapped(){
        delegate?.cellTapped(self.model_!)
    }
    
    private func layout(){
        
        let stackView = UIStackView.makeStackView(axis: .vertical)
        stackView.spacing = 6
        
        let views: [UIView] = [title,author]
        views.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        let mainViews: [UIView] = [previewImage,stackView]
        mainViews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        NSLayoutConstraint.activate([
            previewImage.topAnchor.constraint(equalTo: topAnchor),
            previewImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewImage.heightAnchor.constraint(equalToConstant: trackCellHeight),
            previewImage.widthAnchor.constraint(equalToConstant: trackCellHeight),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: previewImage.trailingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3)
        ])
    }
}

extension MusicTrackCollectionViewCell: PlayerItem{
    func setUpDelegate(delegate: PlayerItemsDelegate) {
        self.delegate = delegate as? any MusicTrackCVDelegate
    }
}
