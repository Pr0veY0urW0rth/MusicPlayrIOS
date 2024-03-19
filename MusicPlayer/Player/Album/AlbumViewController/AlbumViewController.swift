//
//  AlbumViewController.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit

class AlbumViewController: UIViewController, UITableViewDelegate, TableCellDelegate {
    private var viewModel: AlbumViewModel
    
    private lazy var tableView =  UITableView()
    
    init(albumID: String, albumTitle: String?,albumAuthor: String?) {
        let title: String = albumTitle ?? ""
        let author: String = albumAuthor ?? ""
        self.viewModel = AlbumViewModel(albumId: albumID, albumTitle: title,albumAuthor: author)
        super.init(nibName: nil, bundle: nil)
    }
    
    private let header: PlaylistHeader = {
        let header = PlaylistHeader()
        return header
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData(table: self.tableView)
        setupView()
        setTableAnchors()
        setUpdDelegates()
        setUpBackground()
        registerCells()
    }
    private func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        let height = 350.0
        var frame = header.frame
        frame.size.height = height
        header.frame = frame
        self.tableView.tableHeaderView = header
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

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getData().count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        header.configure(header: PlaylistHeaderModel(title: viewModel.getAlbumTitle(), desc: viewModel.getAlbumAuthor(), cover: viewModel.getCover()))
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicTrackTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellType.track.cellIdentifier, for: indexPath) as! MusicTrackTableViewCell
        cell.configure(track: viewModel.getData()[indexPath.row])
        cell.setup(delegate: self)
        return cell
    }
}

extension AlbumViewController: MusicTrackTCDdelegate{
    func cellTapped(_ model: Track) {
        let vc: MusicPlayerViewController = MusicPlayerViewController(trackID: model.id,trackTitle: model.name,trackAuthor: model.artists.first?.name,audio: URL(string: model.preview_url ?? ""))
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
