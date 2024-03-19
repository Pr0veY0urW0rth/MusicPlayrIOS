//
//  TextFieldTableViewCell.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 10.10.2022.
//  Copyright © 2022 ProveY0urWorth. All rights reserved.
//
import UIKit

protocol TextFieldDelegate: TableCellDelegate{
    func cell(text: String,type: CellType)
}


final class TextFieldTableViewCell:UITableViewCell, TableCell, UITextFieldDelegate {
    weak var textDelegate: TextFieldDelegate?
    
    private var passwordIsHidden: Bool = false
    private var textType: CellType = .none
    private var state: State = .valid
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .clear
        tf.textColor = .black
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    private let rightImageView: UIImageView = {
        let rIm = UIImageView()
        rIm.image = nil
        return rIm
    }()
    
    private func disableAutoFill() {
        if #available(iOS 12, *) {
            textField.textContentType = .oneTimeCode
        } else {
            textField.textContentType = .init(rawValue: "")
        }
    }
    
    private func setHighlight(state: State){
        switch state{
        case .invalid:
            textField.layer.borderWidth = 2.0
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.cornerRadius = 10.0
        case .valid:
            textField.layer.borderWidth = 2.0
            textField.layer.borderColor = UIColor.darkGray.cgColor
            textField.layer.cornerRadius = 10.0
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        textDelegate?.cell(text: textField.text ?? "",type: textType)
        self.setHighlight(state: .valid)
    }
    
    func configure(with placeholder: String,type: CellType,text: String,state: State){
        let redPlaceholderText = NSAttributedString(string: placeholder,
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        setHighlight(state: state)
        textField.attributedPlaceholder = redPlaceholderText
        textField.enablesReturnKeyAutomatically = true;
        self.textType = type
        textField.keyboardType = .asciiCapable
        textField.keyboardAppearance = .default
        textField.textContentType = .emailAddress
        if (placeholder == AuthStrings.password || placeholder == AuthStrings.repeatPassword){
            textField.isSecureTextEntry = true
            passwordIsHidden = true
            rightImageView.image = UIImage(systemName: Images.showPassword)
            rightImageView.tintColor = .darkGray
            rightImageView.isUserInteractionEnabled = true
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            rightImageView.addGestureRecognizer(tapRecognizer)
            textField.rightView = rightImageView
            textField.rightViewMode = .unlessEditing
            disableAutoFill() // need this because of bug in IOS 14 and higher
        }
        textField.text = text
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupAnchors()
    }
    required init?(coder: NSCoder) {
        fatalError(Errors.fatalError)
    }
    
    override func prepareForReuse() {
        textField.text = .none
        textField.isSecureTextEntry = false
        passwordIsHidden = false
        textField.rightView = nil
        self.setHighlight(state: .valid)
    }
    
    @objc private func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
        _ = gestureRecognizer.view!
        if passwordIsHidden{
            textField.isSecureTextEntry = false
            rightImageView.image = UIImage(systemName: Images.hidePassword)
        }else{
            textField.isSecureTextEntry = true
            rightImageView.image = UIImage(systemName: Images.showPassword)
        }
        passwordIsHidden = !passwordIsHidden
    }
    
    private func setupAnchors(){
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        self.contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}

extension TextFieldTableViewCell: TableViewCell{
    func setup(delegate: TableCellDelegate) {
        self.textDelegate = delegate as? any TextFieldDelegate
    }
    
    func configureCell(type: CellType,text: String,state: State){
        switch type{
        case .login:
            configure(with: AuthStrings.login,type: type,text: text,state: state)
        case .email:
            configure(with: AuthStrings.email,type: type,text: text,state: state)
        case .password:
            configure(with: AuthStrings.password,type: type,text: text,state: state)
        case .repeatPassword:
            configure(with: AuthStrings.repeatPassword,type: type,text: text,state: state)
        default: break;
        }
    }
    
    var cellReuseIdentifier: String {
        return CellsIndetifiers.textField
    }
}
