//
//  ArtistHeader.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 08.01.2023.
//

import UIKit

protocol ArtistHeaderDelegate: HeaderDelegate{
    func playerControlViewDidTapLikeButton(_ artistHeader: ArtistHeader)
}

struct ArtistHeaderModel{
    let title: String
    let cover: String
}

final class ArtistHeader: UICollectionViewCell {
    weak var delegate: ArtistHeaderDelegate?
    
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
        super.init(frame: .zero)
        layout()
        setUpTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        let buttonSize = 75.0
        
        let views: [UIView] = [cover,title,likeBtn]
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
            title.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 2),
            //title.centerXAnchor.constraint(equalTo: centerXAnchor),
            //title.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 10),
            
            likeBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            likeBtn.widthAnchor.constraint(equalToConstant: buttonSize),
            likeBtn.heightAnchor.constraint(equalToConstant: buttonSize),
            likeBtn.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 5)
        ])
    }
    
    func configure(header: ArtistHeaderModel){
        title.text = header.title
        cover.sd_setImage(with: URL(string: header.cover ), completed: nil)
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
        likeBtn.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
    }
}

extension ArtistHeader: Header{
    func setUpDelegate(delegate: HeaderDelegate) {
        self.delegate = delegate as? any ArtistHeaderDelegate
    }
}
