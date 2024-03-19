//
//  ProfileTableViewCell.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell, TableCell{
    private let profilePicSize: CGFloat = 64
    
    private let username: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        return label
    }()
    
    private let email: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .black
        label.alpha = 0.7
        return label
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Errors.fatalError)
    }
    
    func configure(){
        profileImage.image = UIImage(systemName: Images.profilePic)
        profileImage.tintColor = .black
        username.text = UserManager.login
        email.text = UserManager.email
        self.backgroundColor = .clear
    }
    
    private func layout(){
        let stackView = UIStackView.makeStackView(axis: .vertical)
        stackView.spacing = 6
        
        let views: [UIView] = [username,email]
        views.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        let mainViews: [UIView] = [profileImage,stackView]
        mainViews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: profilePicSize),
            profileImage.widthAnchor.constraint(equalToConstant: profilePicSize),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: profileImage.trailingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3)
        ])
    }
}

extension ProfileTableViewCell: TableViewCell {
    func setup(delegate: TableCellDelegate) {
    }
    
    func configureCell(type: CellType,text: String,state: State){
        configure()
    }
    
    var cellReuseIdentifier: String {
        return CellsIndetifiers.profile
    }
}
