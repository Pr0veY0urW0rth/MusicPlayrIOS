//
//  SettingsViewController.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit

final class SettingsViewController: UIViewController, UITableViewDelegate{
    
    private lazy var tableView = UITableView()
    private var dataSource: [CellType] = [.profile, .exit,.signOut]
    private var viewModel: SettingsViewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        setTableAnchors()
        registerCells()
        setupUI()
        setTableViewDelegate()
        setupBackground()
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
        navigationItem.title = PlayerStrings.settingsTitle
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupBackground(){
        let background = UIImage(named: Images.playerBackgroundImage)
        
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        tableView.backgroundColor = .artemisBackgroundTransperent
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableCell = tableView.dequeueReusableCell(withIdentifier: dataSource[indexPath.row].cellIdentifier, for: indexPath) as! TableCell
        cell.configureCell(type: dataSource[indexPath.row],text: viewModel.cellText(type: dataSource[indexPath.row]), state: viewModel.cellState(type: dataSource[indexPath.row]))
        cell.selectionStyle = .none
        cell.setup(delegate: self)
        return cell
    }
}

extension SettingsViewController: ButtonDelegate{
    func btnTapped(type: CellType) {
        switch type{
        case .signOut:
            UserManager.isLoggedIn = false
            SpotifyAuthManager.shared.signOut{signedOut in
                    if signedOut {
                        DispatchQueue.main.async {
                            let appDelegate = UIApplication.shared.delegate as? AppDelegate
                            let vc = AuthViewController()
                            vc.modalPresentationStyle = .fullScreen
                            appDelegate?.switchControllers(viewControllerToBeDismissed: self, controllerToBePresented: vc)
                        }
                    }
            }
        default: break;
        }
    }
}
