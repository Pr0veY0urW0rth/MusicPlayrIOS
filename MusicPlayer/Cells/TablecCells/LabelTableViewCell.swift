//
//  LabelTableViewCell.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 10.10.2022.
//  Copyright © 2022 ProveY0urWorth. All rights reserved.
//

import UIKit

final class LabelTableViewCell:UITableViewCell, TableCell{
    func setup(delegate: TableCellDelegate) {}
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(FontSize.label)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAnchorcs()
        
    }
    required init?(coder: NSCoder) {
        fatalError(Errors.fatalError)
    }
    
    func configure (with sample: String,textColor: UIColor){
        infoLabel.text = sample
        infoLabel.textColor = textColor
        self.backgroundColor = .clear
    }
    
    private func setupAnchorcs() {
        selectionStyle = .none
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
}

extension LabelTableViewCell: TableViewCell {
    func configureCell(type: CellType,text: String,state: State){
        switch type{
        case .helloWord:
            configure(with: AuthStrings.helloWord,textColor: .black)
        case .accountExists:
            configure(with: AuthStrings.accountExists,textColor: .black)
        case .accountNotExists:
            configure(with: AuthStrings.accountNotExists,textColor: .black)
        case .spotifyInfo:
            configure(with: AuthStrings.spotifyInf, textColor: .black)
        case .exit:
            configure(with: AuthStrings.exit,textColor: .black)
        case .spacer:
            configure(with: "", textColor: .clear)
        default: break;
        }
    }
    
    var cellReuseIdentifier: String {
        return CellsIndetifiers.label
    }
}

