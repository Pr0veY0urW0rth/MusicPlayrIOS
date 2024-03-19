//
//  ButtonTableViewCell.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 10.10.2022.
//  Copyright © 2022 ProveY0urWorth. All rights reserved.
//

import UIKit

protocol ButtonDelegate: TableCellDelegate{
    func btnTapped(type: CellType)
}

final class ButtonTableViewCell: UITableViewCell, TableCell{
    
    weak var delegate: ButtonDelegate?
    private var buttonType: CellType = CellType.none
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupAnchorcs()
    }
    required init?(coder: NSCoder) {
        fatalError(Errors.fatalError)
    }
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.layer.borderColor = UIColor.black.cgColor
        //btn.layer.borderWidth = 2
        return btn
    }()
    
    func  configure(with text: String, color:UIColor, btnType:CellType)  {
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5,leading: 10,bottom: 5,trailing: 10)
        configuration.attributedTitle = AttributedString(text)
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = color
        button.configuration = configuration
        self.buttonType = btnType
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
    }
    
    @objc private func buttonClick(sender: UIButton) {
        delegate?.btnTapped(type: self.buttonType)
    }
    
    private func setupAnchorcs(){
        self.contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 64),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

extension ButtonTableViewCell: TableViewCell {
    func setup(delegate: TableCellDelegate) {
        self.delegate = delegate as? any ButtonDelegate
    }
    
    func configureCell(type: CellType,text: String,state: State){
        switch type{
        case .signUp:
            configure(with: AuthStrings.signUp, color: .artemisButtonBackground, btnType: type)
        case .signIn:
            configure(with: AuthStrings.signIn, color: .artemisButtonBackground, btnType: type)
        case .signOut:
            configure(with: AuthStrings.signOut, color: .artemisButtonBackground, btnType: type)
        default: break;
        }
    }
    
    var cellReuseIdentifier: String {
        return CellsIndetifiers.button
    }
}
