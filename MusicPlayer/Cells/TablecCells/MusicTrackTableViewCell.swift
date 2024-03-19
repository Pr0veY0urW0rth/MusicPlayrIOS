//
//  MusicTrackTableViewCell.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit
import SDWebImage

protocol MusicTrackTCDdelegate: TableCellDelegate{
    func cellTapped(_ model: Track)
}

final class MusicTrackTableViewCell: UITableViewCell{
    private let trackCellHeight: CGFloat = 64
    
    weak var delegate: MusicTrackTCDdelegate?
    
    private var id: String = ""
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        return label
    }()
    
    private let author: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Errors.fatalError)
    }
    
    func configure(track: Track){
        id = track.id
        previewImage.sd_setImage(with: URL(string: track.album?.images.first?.url ?? Images.trackPlaceholder), completed: nil)
        fullImage.sd_setImage(with: URL(string: track.album?.images.first?.url ?? Images.trackPlaceholder), completed: nil)
        title.text = track.name
        author.text = track.artists[0].name
        duration = track.duration_ms
        audio = URL(string: track.preview_url!)
        self.model_ = track
        self.backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(trackTapped))
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
            previewImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            previewImage.heightAnchor.constraint(equalToConstant: trackCellHeight),
            previewImage.widthAnchor.constraint(equalToConstant: trackCellHeight),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: previewImage.trailingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3)
        ])
    }
}

extension MusicTrackTableViewCell: TableViewCell{
    var cellReuseIdentifier: String {
        return CellType.track.cellIdentifier
    }
    
    func configureCell(type: CellType, text: String, state: State) {}
    
    func setup(delegate: TableCellDelegate) {
        self.delegate = delegate as? any MusicTrackTCDdelegate
    }
}
