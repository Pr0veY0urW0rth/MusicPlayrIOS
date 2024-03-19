//
//  HomeHeader.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 04.01.2023.
//

import UIKit


protocol HomeHeaderDelegate: HeaderDelegate{
    func didTapRecent(_ homeHeader: HomeHeader)
    func didTapOptions(_ homeHeader: HomeHeader)
}
final class HomeHeader: UICollectionViewCell{
    
    weak var delegate: HomeHeaderDelegate?
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: FontTypes.poppinsBold, size: 28)
        return label
    }()
    
    private let recentBtn: UIButton = {
        let btn = UIButton()
         btn.tintColor = .black
         btn.backgroundColor = .clear
        let image = UIImage(systemName: Images.recent ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        btn.setImage(image, for: .normal)
         return btn
    }()
    
    private let optionsBtn: UIButton = {
        let btn = UIButton()
         btn.tintColor = .black
         btn.backgroundColor = .clear
        let image = UIImage(systemName: Images.options ,withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        btn.setImage(image, for: .normal)
         return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAnchors()
        setupLabelText()
        setUpTargets()
    }
    
    private func setupLabelText(){
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour{
        case 5..<12 : greetingLabel.text = PlayerStrings.morning
        case 12..<18 : greetingLabel.text = PlayerStrings.afternoon
        default: greetingLabel.text = PlayerStrings.evening
        }
    }
    
    @objc private func didTapRecent(){
        delegate?.didTapRecent(self)
    }
    
    @objc private func didTapOptions(){
        delegate?.didTapOptions(self)
    }
    
    private func setUpTargets(){
        recentBtn.addTarget(self, action: #selector(didTapRecent), for: .touchUpInside)
        optionsBtn.addTarget(self, action: #selector(didTapOptions), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAnchors(){
        let views: [UIView] = [greetingLabel,optionsBtn]
        views.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            greetingLabel.topAnchor.constraint(equalTo: topAnchor),
            greetingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            greetingLabel.widthAnchor.constraint(equalToConstant: 200),
            
//            recentBtn.trailingAnchor.constraint(equalTo: optionsBtn.leadingAnchor,constant: -10),
//            recentBtn.topAnchor.constraint(equalTo: topAnchor),
//            recentBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
//            recentBtn.widthAnchor.constraint(equalToConstant: 50),
            
            optionsBtn.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            optionsBtn.topAnchor.constraint(equalTo: topAnchor),
            optionsBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
            optionsBtn.widthAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}

extension HomeHeader: Header{
    func setUpDelegate(delegate: HeaderDelegate) {
        self.delegate = delegate as? any HomeHeaderDelegate
    }
}
