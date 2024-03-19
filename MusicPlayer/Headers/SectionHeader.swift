//
//  SectionHeader.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 04.01.2023.
//

import Foundation
import UIKit

enum SectionHeaderType{
    case header
    case artists
    case albums
    case playlists
    case tracks
}

final class SectionHeader: UICollectionReusableView{
    private var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.font = UIFont(name: FontTypes.poppinsBold, size: 28)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpHeader(type:SectionHeaderType){
        switch type{
        case .artists:
            label.text = PlayerStrings.artistSectionTitle
        case .albums:
            label.text = PlayerStrings.albumsSectionTitle
        case .playlists:
            label.text = PlayerStrings.playlistSectionTitle
        default:
            label.text = PlayerStrings.trackSectionTitle
        }
    }
    
    private func setUpLayout(){
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
