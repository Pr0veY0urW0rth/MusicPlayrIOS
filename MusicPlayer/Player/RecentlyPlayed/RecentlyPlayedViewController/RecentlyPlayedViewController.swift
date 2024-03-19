//
//  RecentlyPlayedViewController.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit

final class RecentlyPlayedViewController: UIViewController{
    private var viewModel = RecentlyPlayedViewModel()
    
    private lazy var tableView =  UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTableAnchors()
        setUpdDelegates()
        setUpBackground()
        registerCells()
    }
    private func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setTableAnchors(){
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func setUpdDelegates(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setUpBackground(){
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
    
    private func registerCells(){
        tableView.register(CellType.track.cellClass, forCellReuseIdentifier: CellType.track.cellIdentifier)
    }
}

extension RecentlyPlayedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of playlist items
        return viewModel.getData().count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicTrackTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellType.track.cellIdentifier, for: indexPath) as! MusicTrackTableViewCell
        cell.configure(track: viewModel.getData()[indexPath.row])
        return cell
    }
}

extension RecentlyPlayedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle tap on playlist item
    }
}
