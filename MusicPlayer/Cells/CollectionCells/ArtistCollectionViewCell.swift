//
//  ArtistCollectionViewCell.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 18.12.2022.
//

import SDWebImage
import UIKit

protocol ArtistCVDelegate: PlayerItemsDelegate{
    func cellTapped(_ model: Artist)
}

final class ArtistCollectionViewCell: UICollectionViewCell{
    weak var delegate: ArtistCVDelegate?
    
    private var id: String = ""
    private let artistName: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let previewImage: UIImageView = {
        let imageView = UIImageView()
        //imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        //imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    private let fullImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var model: Artist?
    
    func modelProperty() -> Artist{
        return self.model!
    }
    
    func configure(artist: Artist){
        self.id = artist.id
        artistName.text = artist.name
        previewImage.sd_setImage(with: URL(string: artist.images?.first?.url ?? ""), completed: nil)
        fullImage.sd_setImage(with: URL(string: artist.images?.first?.url ?? ""), completed: nil)
        self.model = artist
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(artistTapped))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func artistTapped(){
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
        let views: [UIView] = [artistName,previewImage]
        views.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            previewImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            previewImage.heightAnchor.constraint(equalToConstant: 120),
            previewImage.widthAnchor.constraint(equalToConstant: 120),
            
            artistName.topAnchor.constraint(equalToSystemSpacingBelow: previewImage.bottomAnchor, multiplier: 2),
            artistName.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            artistName.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
    }
}

extension ArtistCollectionViewCell: PlayerItem{
    func setUpDelegate(delegate: PlayerItemsDelegate) {
        self.delegate = delegate as? any ArtistCVDelegate
    }
}
