//
//  CategoryCollectionViewCell.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 04.01.2023.
//

import UIKit
import SDWebImage

protocol CategoryCVDelegate: PlayerItemsDelegate{
    func cellTapped(_ model: Category)
}

final class CategoryCollectionViewCelll: UICollectionViewCell{
    private var id: String = ""
    
    weak var delegate: CategoryCVDelegate?
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: FontTypes.poppinsSemibold, size: 22)
        label.numberOfLines = 2
        return label
    }()
    
    private var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.image = UIImage(
            systemName: "music.quarternote.3",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 50,
                weight: .regular)
        )
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemRed,
        .systemGreen,
        .systemBlue,
        .systemMint,
        .systemOrange,
        .systemPurple,
        .systemCyan
    ]
    
    private var model: Category?
    
    func modelProperty() -> Category{
        return self.model!
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        image.image = UIImage(
            systemName: "music.quarternote.3",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 50,
                weight: .regular)
        )
    }
    
    func configure(category: Category){
        label.text = category.name
        model = category
        image.sd_setImage(with: URL(string: category.icons.first?.url ?? ""), completed: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(categoryTapped))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func categoryTapped(){
        delegate?.cellTapped(self.model!)
    }
    
    private func layout(){
        let views: [UIView] = [label,image]
        views.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        //view.translatesAutoresizingMaskIntoConstraints = false
        //contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 150),
            image.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            
            label.heightAnchor.constraint(equalToConstant: 32),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
        ])
        //view.backgroundColor = colors.randomElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCollectionViewCelll: PlayerItem{
    func setUpDelegate(delegate: PlayerItemsDelegate) {
        self.delegate = delegate as? any CategoryCVDelegate
    }
}
