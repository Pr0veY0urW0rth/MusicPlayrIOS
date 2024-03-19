//
//  ViewController.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 10.10.2022.
//  Copyright © 2022 ProveY0urWorth. All rights reserved.
//
import UIKit

class AuthViewController:  UIViewController, UITableViewDelegate, UITextFieldDelegate,TableCellDelegate{
    
    private lazy var tableView = UITableView()
    private var dataSource: [CellType] = [.helloWord, .login, .email, .password, .repeatPassword,.spacer, .signUp,.spacer,.spacer, .accountExists, .signIn]
    var currentMode: AuthMode = .signUpMode
    private var viewModel: AuthViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        setTableAnchors()
        registerCells()
        setupUI()
        self.HideKeyboardOnTap()
        setTableViewDelegate()
        self.view.backgroundColor = .artemisBackground
        tableView.backgroundColor = .clear
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func setTableAnchors(){
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func registerCells(){
        dataSource.forEach(){element in
            tableView.register(element.cellClass, forCellReuseIdentifier: element.cellIdentifier)
        }
    }
    
    private func setTableViewDelegate(){
        tableView.delegate  = self
        tableView.dataSource = self
    }
    
    private func setupUI(){
        navigationItem.title = AuthStrings.title
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
}

extension AuthViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableCell = tableView.dequeueReusableCell(withIdentifier: dataSource[indexPath.row].cellIdentifier, for: indexPath) as! TableCell
        cell.configureCell(type: dataSource[indexPath.row],text: viewModel.GetCellText(type: dataSource[indexPath.row]), state: viewModel.GetCellState(type: dataSource[indexPath.row]))
        cell.selectionStyle = .none
        cell.setup(delegate: self)
        return cell
    }
}

extension AuthViewController {
    func HideKeyboardOnTap() {
        //Введение поясняющей переменной
        let tap = UITapGestureRecognizer(target: self, action: #selector(AuthViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
    }
}
extension AuthViewController: ButtonDelegate{//button taps
    func btnTapped(type: CellType) {
        let check: Validator
        switch currentMode{
        case .signUpMode:
            switch type{
            case .signUp:
                check = viewModel.validate(mode: .signUpMode)
                if(check.succes){
                    //alertPresent(alertTitle: check.alertTitle,alertText: check.alert)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let vc = SpotifyAuthViewController()
                    vc.modalPresentationStyle = .fullScreen
                    appDelegate.switchControllers(viewControllerToBeDismissed: self, controllerToBePresented: vc)
                }else{
                    alertPresent(alertTitle: check.alertTitle,alertText: check.alert)
                    tableView.reloadData()
                }
            case .signIn:
                dataSource.removeAll()
                dataSource = [.helloWord, .login, .password,.spacer, .signIn, .accountNotExists, .signUp]
                viewModel.ClearCells()
                currentMode = .signInMode
                tableView.reloadData()
            default:
                break;
            }
            
        case .signInMode:
            switch type{
            case .signUp:
                dataSource.removeAll()
                dataSource = [.helloWord, .login, .email, .password, .repeatPassword,.spacer, .signUp,.spacer,.spacer, .accountExists, .signIn]
                viewModel.ClearCells()
                currentMode = .signUpMode
                tableView.reloadData()
                
            case .signIn:
                check = viewModel.validate(mode: .signInMode)
                if(check.succes){
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let vc = SpotifyAuthViewController()
                    vc.modalPresentationStyle = .fullScreen
                    appDelegate.switchControllers(viewControllerToBeDismissed: self, controllerToBePresented: vc)
                }else{
                    alertPresent(alertTitle: check.alertTitle,alertText: check.alert)
                    tableView.reloadData()
                }
            default: break;
            }
        }
    }
}

extension AuthViewController: TextFieldDelegate{//text transfer
    func cell(text: String,type: CellType){
        switch type{
        case .login:
            viewModel.Update(mode: currentMode, type: .login, text: text)
        case .email:
            viewModel.Update(mode: currentMode, type: .email, text: text)
        case .password:
            viewModel.Update(mode: currentMode, type: .password, text: text)
        case .repeatPassword:
            viewModel.Update(mode: currentMode, type: .repeatPassword, text: text)
        default:
            break;
        }
    }
}

extension AuthViewController{
    private func alertPresent(alertTitle: String,alertText: String){
        let alert = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AuthStrings.ok, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
