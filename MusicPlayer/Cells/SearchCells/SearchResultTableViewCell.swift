//
//  SearchResultTableViewCell.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 05.01.2023.
//

import UIKit

final class SearchResultTableViewCell:UITableViewCell{
    static let identifier = "SearchResultTableViewCell"
    
    private let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        title.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(image)
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            image.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            image.widthAnchor.constraint(equalToConstant: 70),
            image.heightAnchor.constraint(equalToConstant: 70),
            
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            title.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        image.image = UIImage(named: Images.trackPlaceholder)
    }
    
    func configure(){
        title.text = "Placeholder"
        image.image = UIImage(named: Images.trackPlaceholder)
        self.backgroundColor = .clear
    }
}
