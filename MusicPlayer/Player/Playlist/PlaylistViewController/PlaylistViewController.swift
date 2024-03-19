//
//  PlaylistViewController.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDelegate {
    private var viewModel: PlaylistViewModel
    
    private lazy var tableView =  UITableView()
    
    init(playlistID: String, playlistTitle: String?,playlistDesc: String?) {
        let title: String = playlistTitle ?? ""
        let desc: String = playlistDesc ?? ""
        self.viewModel = PlaylistViewModel(playlistId: playlistID, playlistTitle: title,playlistDesc: desc)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let header: PlaylistHeader = {
       let header = PlaylistHeader()
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData(table: tableView)
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
        header.setUpDelegate(delegate: self)
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

extension PlaylistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of playlist items
        return viewModel.getData().count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        header.configure(header: PlaylistHeaderModel(title: viewModel.getPlaylistTitle(), desc: viewModel.getPlaylistDescription(), cover: viewModel.getCover()))
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicTrackTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellType.track.cellIdentifier, for: indexPath) as! MusicTrackTableViewCell
        cell.configure(track: viewModel.getData()[indexPath.row])
        cell.selectionStyle = .none
        cell.setup(delegate: self)
        return cell
    }
}

extension PlaylistViewController: PlaylistHeaderDelegate{
    func playerControlViewDidTapPlayPauseButton(_ playlistHeader: PlaylistHeader) {
        
    }
    
    func playerControlViewDidTapMixButton(_ playlistHeader: PlaylistHeader) {
        
    }
    
    func playerControlViewDidTapLikeButton(_ playlistHeader: PlaylistHeader) {
        
    }
}

extension PlaylistViewController: MusicTrackTCDdelegate{
    func cellTapped(_ model: Track) {
        let vc: MusicPlayerViewController = MusicPlayerViewController(trackID: model.id,trackTitle: model.name,trackAuthor: model.artists.first?.name,audio: URL(string: model.preview_url ?? ""))
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
