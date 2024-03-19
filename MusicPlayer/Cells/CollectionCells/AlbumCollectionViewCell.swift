//
//  AlbumCollectionViewCell.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 18.12.2022.
//
import UIKit
import SDWebImage

protocol AlbumCVDelegate: PlayerItemsDelegate{
    func cellTapped(_ model: Album)
}

final class AlbumCollectionViewCell: UICollectionViewCell{
    private let trackCellHeight: CGFloat = 64

    weak var delegate: AlbumCVDelegate?
    
    private var id: String = ""
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontTypes.poppins, size: 24)
        label.textColor = .black
        return label
    }()
    
    private let author:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontTypes.poppinsLight, size: 18)
        label.textColor = .black
        label.alpha = 0.7
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
    
    private var audio: URL? = URL(string: "")
    
    private var model_: Album?
    
    func modelProperty() -> Album{
        return self.model_!
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Errors.fatalError)
    }
    
    func configure(album: Album){
        id = album.id
        previewImage.sd_setImage(with: URL(string: album.images.first?.url ?? Images.trackPlaceholder), completed: nil)
        fullImage.sd_setImage(with: URL(string: album.images.first?.url ?? Images.trackPlaceholder), completed: nil)
        title.text = album.name
        author.text = album.artists.first?.name
        self.model_ = album
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(albumTapped))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func albumTapped(){
        delegate?.cellTapped(self.model_!)
    }
    
    private func layout(){
        let stackView = UIStackView.makeStackView(axis: .vertical)
        stackView.spacing = 6
        
        let views: [UIView] = [title,author]
        views.forEach{
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
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

extension AlbumCollectionViewCell: PlayerItem{
    func setUpDelegate(delegate: PlayerItemsDelegate) {
        self.delegate = delegate as? any AlbumCVDelegate
    }
}
