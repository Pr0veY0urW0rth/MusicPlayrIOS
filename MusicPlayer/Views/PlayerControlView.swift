//
//  PlayerControlView.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 06.01.2023.
//

import UIKit

enum RepeatType{
    case none
    case repeatAll
    case repeatThis
}

protocol PlayerControlViewDelegate: AnyObject{
    func playerControlViewDidTapPlayPauseButton(_ playerControlView: PlayerControlView)
    func playerControlViewDidTapForwardButton(_ playerControlView: PlayerControlView)
    func playerControlViewDidTapBackwardsButton(_ playerControlView: PlayerControlView)
    func playerControlViewDidTapMixButton(_ playerControlView: PlayerControlView)
    func playerControlViewDidTapRepeatButton(_ playerControlView: PlayerControlView)
    func playerControlViewDidTapLikeButton(_ playerControlView: PlayerControlView)
    func playerControlViewDidTapMoreButtin(_ playerControlView: PlayerControlView)
    func playerControlView(_ playerControlView: PlayerControlView, didSlideSlider value: Float)
}

struct PlayerControlViewModel{
    let title: String
    let author: String
    let totalTime: Int
}

final class PlayerControlView: UIView{
    private var isPlaying = true
    private var isMixed = false
    private var isLiked = false
    private var onRepeat: RepeatType = .none
    
    weak var delegate: PlayerControlViewDelegate?
    
    private var songTimeSlider: UISlider = {
        let slider = UISlider()
        slider.maximumTrackTintColor = .black
        slider.minimumTrackTintColor = .black
        slider.thumbTintColor = .black
        return slider
    }()
    
    private var titleLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private var authorLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private var currentTime: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    private var totalTime: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    private var playPauseBtn: UIButton = {
        let btn = UIButton()
        btn.tintColor = .black
        btn.backgroundColor = .clear
        let image = UIImage(systemName: Images.isPaused,withConfiguration: UIImage.SymbolConfiguration(pointSize: 60,weight: .light))
        btn.setImage(image, for: .normal)
        let imageSelected = UIImage(systemName: Images.isPlaying, withConfiguration: UIImage.SymbolConfiguration(pointSize: 60,weight: .light))
        btn.setImage(imageSelected, for: .selected)
        return btn
    }()
    
    private var previousBtn: UIButton = {
        let btn = UIButton()
         btn.tintColor = .black
         btn.backgroundColor = .clear
        let image = UIImage(systemName:  Images.previous,withConfiguration: UIImage.SymbolConfiguration(pointSize: 42,weight: .regular))
        btn.setImage(image, for: .normal)
         return btn
    }()
    
    private var nextBtn: UIButton = {
        let btn = UIButton()
         btn.tintColor = .black
         btn.backgroundColor = .clear
        let image = UIImage(systemName: Images.next ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 42,weight: .regular))
        btn.setImage(image, for: .normal)
         return btn
    }()
    
    private var mixBtn: UIButton = {
        let btn = UIButton()
        btn.tintColor = .black
        btn.backgroundColor = .clear
        let image = UIImage(systemName: Images.mix ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 36,weight: .regular))
        btn.setImage(image, for: .normal)
        btn.setImage(image, for: .selected)
        return btn
    }()
    
    private var repeatBtn: UIButton = {
        let btn = UIButton()
         btn.tintColor = .black
         btn.backgroundColor = .clear
        let image = UIImage(systemName: Images.again ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 36,weight: .regular))
        btn.setImage(image, for: .normal)
         return btn
    }()
    
    private var likeBtn: UIButton = {
        let btn = UIButton()
        btn.tintColor = .black
        btn.backgroundColor = .clear
        let image = UIImage(systemName: Images.isNotLiked ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 40,weight: .regular))
        btn.setImage(image, for: .normal)
        let imageSelected = UIImage(systemName: Images.isLiked, withConfiguration: UIImage.SymbolConfiguration(pointSize: 40,weight: .regular))
        btn.setImage(imageSelected, for: .selected)
        return btn
    }()
    
    private var moreBtn: UIButton = {
        let btn = UIButton()
        btn.tintColor = .black
        btn.backgroundColor = .clear
        let image = UIImage(systemName: Images.more,withConfiguration: UIImage.SymbolConfiguration(pointSize: 40,weight: .regular))
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    @objc private func didTapPlayPause(){
        self.isPlaying = !isPlaying
        playPauseBtn.isSelected = isPlaying
        delegate?.playerControlViewDidTapPlayPauseButton(self)
    }
    
    @objc private func didTapPrevious(){
        delegate?.playerControlViewDidTapBackwardsButton(self)
    }
    
    @objc private func didTapNext(){
        delegate?.playerControlViewDidTapForwardButton(self)
    }
    
    @objc private func didTapMix(){
        self.isMixed = !isMixed
        mixBtn.isSelected = isMixed
        if(mixBtn.isSelected){
            mixBtn.tintColor = .artemisButtonBackground
        }
        else{
            mixBtn.tintColor = .black
        }
        delegate?.playerControlViewDidTapMixButton(self)
    }
    
    @objc private func didTapRepeat(){
        switch onRepeat{
        case .none:
            let image = UIImage(systemName: Images.again, withConfiguration: UIImage.SymbolConfiguration(pointSize: 36,weight: .regular))
            repeatBtn.setImage(image, for: .normal)
            repeatBtn.tintColor = .artemisButtonBackground
            onRepeat = .repeatAll
        case .repeatAll:
            let image = UIImage(systemName: Images.againOne, withConfiguration: UIImage.SymbolConfiguration(pointSize: 36,weight: .regular))
            repeatBtn.setImage(image, for: .normal)
            repeatBtn.tintColor = .artemisButtonBackground
            onRepeat = .repeatThis
        case .repeatThis:
            let image = UIImage(systemName: Images.again, withConfiguration: UIImage.SymbolConfiguration(pointSize: 36,weight: .regular))
            repeatBtn.setImage(image, for: .normal)
            repeatBtn.tintColor = .black
            onRepeat = .none
        }
        delegate?.playerControlViewDidTapRepeatButton(self)
    }
    
    @objc private func didTapLike(){
        self.isLiked = !isLiked
        likeBtn.isSelected = isLiked
        if(likeBtn.isSelected){
            likeBtn.tintColor = .artemisButtonBackground
        }
        else{
            likeBtn.tintColor = .black
        }
        delegate?.playerControlViewDidTapLikeButton(self)
    }
    
    @objc private func didTapMore(){
        delegate?.playerControlViewDidTapMoreButtin(self)
    }
    
    @objc private func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        delegate?.playerControlView(self, didSlideSlider: value)
    }
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        backgroundColor = .clear
        layout()
        setUpTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTargets(){
        previousBtn.addTarget(self, action: #selector(didTapPrevious), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseBtn.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        mixBtn.addTarget(self, action: #selector(didTapMix), for: .touchUpInside)
        repeatBtn.addTarget(self, action: #selector(didTapRepeat), for: .touchUpInside)
        likeBtn.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        moreBtn.addTarget(self, action: #selector(didTapMore), for: .touchUpInside)
        // Add target for slider
        songTimeSlider.addTarget(self, action: #selector(didSlideSlider), for: .valueChanged)
    }
    
    private func layout(){
        let buttonSize = 75.0
        
        let views: [UIView] = [moreBtn,titleLable,authorLabel,songTimeSlider,currentTime, totalTime, playPauseBtn,previousBtn,mixBtn,nextBtn,repeatBtn,likeBtn]
        views.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            moreBtn.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 0),
            moreBtn.widthAnchor.constraint(equalToConstant: buttonSize),
            moreBtn.heightAnchor.constraint(equalToConstant: buttonSize),
            moreBtn.centerYAnchor.constraint(equalTo: titleLable.centerYAnchor,constant: 30),
            
            titleLable.topAnchor.constraint(equalTo: topAnchor),
            titleLable.leadingAnchor.constraint(equalTo: moreBtn.trailingAnchor,constant: 2),
            titleLable.trailingAnchor.constraint(equalTo: likeBtn.leadingAnchor,constant: 2),
            
            authorLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor,constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: moreBtn.trailingAnchor,constant: 2),
            authorLabel.trailingAnchor.constraint(equalTo: likeBtn.leadingAnchor,constant: 2),
            
            likeBtn.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 0),
            likeBtn.widthAnchor.constraint(equalToConstant: buttonSize),
            likeBtn.heightAnchor.constraint(equalToConstant: buttonSize),
            likeBtn.centerYAnchor.constraint(equalTo: titleLable.centerYAnchor,constant: 30),
            
            songTimeSlider.topAnchor.constraint(equalTo: authorLabel.bottomAnchor,constant: 50),
            songTimeSlider.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            songTimeSlider.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            songTimeSlider.heightAnchor.constraint(equalToConstant: 40),
            
            currentTime.topAnchor.constraint(equalTo: songTimeSlider.bottomAnchor,constant: 10),
            currentTime.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            
            totalTime.topAnchor.constraint(equalTo: songTimeSlider.bottomAnchor,constant: 10),
            totalTime.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
                        
            playPauseBtn.topAnchor.constraint(equalTo: songTimeSlider.bottomAnchor,constant: 50),
            playPauseBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            playPauseBtn.widthAnchor.constraint(equalToConstant: buttonSize),
            playPauseBtn.heightAnchor.constraint(equalToConstant: buttonSize),

            previousBtn.topAnchor.constraint(equalTo: songTimeSlider.bottomAnchor,constant: 50),
            previousBtn.trailingAnchor.constraint(equalTo: playPauseBtn.leadingAnchor),
            previousBtn.widthAnchor.constraint(equalToConstant: buttonSize),
            previousBtn.heightAnchor.constraint(equalToConstant: buttonSize),
            
            repeatBtn.topAnchor.constraint(equalTo: songTimeSlider.bottomAnchor,constant: 50),
            repeatBtn.trailingAnchor.constraint(equalTo: previousBtn.leadingAnchor),
            repeatBtn.widthAnchor.constraint(equalToConstant: buttonSize),
            repeatBtn.heightAnchor.constraint(equalToConstant: buttonSize),
            
            nextBtn.topAnchor.constraint(equalTo: songTimeSlider.bottomAnchor,constant: 50),
            nextBtn.leadingAnchor.constraint(equalTo: playPauseBtn.trailingAnchor),
            nextBtn.widthAnchor.constraint(equalToConstant: buttonSize),
            nextBtn.heightAnchor.constraint(equalToConstant: buttonSize),
            
            mixBtn.topAnchor.constraint(equalTo: songTimeSlider.bottomAnchor,constant: 50),
            mixBtn.leadingAnchor.constraint(equalTo: nextBtn.trailingAnchor),
            mixBtn.widthAnchor.constraint(equalToConstant: buttonSize),
            mixBtn.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
    }
    
    func configure(model: PlayerControlViewModel){
        titleLable.text = model.title
        authorLabel.text = model.author
        currentTime.text = String("00:00")
        totalTime.text = secondsToString(Double(model.totalTime))
    }
    
    func setCurrentTime(currentTime: Double){
        self.currentTime.text = secondsToString(currentTime)
    }

    func secondsToString(_ time: Double) -> String{
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        let minutes = Int(time/60)
        let str = "\(minutes):\(seconds)"
        return str
    }
}
