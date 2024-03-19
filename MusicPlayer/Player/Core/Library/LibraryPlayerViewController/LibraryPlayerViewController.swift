//
//  LibraryPlayerViewController.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 21.11.2022.
//

import UIKit

class LibraryPlayerViewController: UIViewController,UICollectionViewDelegate, UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
    }
    private let viewModel: LibraryPlayerViewModel = LibraryPlayerViewModel()
    private let headers: [SectionHeaderType] = [.playlists,.albums,.artists]
    
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsViewController())
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = PlayerStrings.searchPlaceholder
        return search
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.backgroundColor = .artemisBackground
        cv.isPagingEnabled = false //fixes the bug with group scroll
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData(collection: self.collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .artemisBackgroundTransperent
        navigationItem.searchController = searchController
        self.view.addSubview(collectionView)
        setCollectionAnchors()
        registerCells()
        setupUI()
        setCollectionViewDelegate()
        setupBackground()
        setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController.searchBar.searchTextField.textColor = .black
        self.searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func setCollectionAnchors(){
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func registerCells(){
        collectionView.register(CollectionCellType.artist.cellClass, forCellWithReuseIdentifier: CollectionCellType.artist.cellIdentifier)
        
        collectionView.register(CollectionCellType.album.cellClass, forCellWithReuseIdentifier: CollectionCellType.album.cellIdentifier)
        collectionView.register(CollectionCellType.playlist.cellClass, forCellWithReuseIdentifier: CollectionCellType.playlist.cellIdentifier)
        
        collectionView.register(HeaderType.sectionHeader.headerClass, forSupplementaryViewOfKind: HeaderType.sectionHeader.headerKinds, withReuseIdentifier: HeaderType.sectionHeader.headerIdentifier)
    }
    
    private func setCollectionViewDelegate(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupUI(){
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.spotifyGreen,.backgroundColor:UIColor.artemisBackground]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.spotifyGreen,.backgroundColor:UIColor.artemisBackground]
        navigationItem.standardAppearance = appearance
        navigationItem.titleView?.backgroundColor = .artemisBackground
    }
    
    private func setupBackground(){
        let background = UIImage(named: Images.playerBackgroundImage)
        
        let imageView: UIImageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        collectionView.backgroundColor = .artemisBackgroundTransperent
    }
}

extension LibraryPlayerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return viewModel.PlaylistSource.count
        case 1:
            return viewModel.AlbumSource.count
        default:
            return viewModel.ArtistSource.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: HeaderType.sectionHeader.headerIdentifier,for: indexPath)as? SectionHeader
        headerView!.setUpHeader(type: headers[indexPath.section])
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell: PlaylistCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellType.playlist.cellIdentifier, for: indexPath) as! PlaylistCollectionViewCell
            cell.configure(playlist: viewModel.PlaylistSource[indexPath.row])
            cell.setUpDelegate(delegate: self)
            return cell
        case 1:
            let cell: AlbumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellType.album.cellIdentifier, for: indexPath) as! AlbumCollectionViewCell
            cell.configure(album: viewModel.AlbumSource[indexPath.row])
            cell.setUpDelegate(delegate: self)
            return cell
        default:
            let cell: ArtistCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellType.artist.cellIdentifier, for: indexPath) as! ArtistCollectionViewCell
            cell.configure(artist: viewModel.ArtistSource[indexPath.row])
            cell.setUpDelegate(delegate: self)
            return cell
        }
    }
}


extension LibraryPlayerViewController{
    private func setUpLayout(){
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0:
                return SectionsFactory.setUpHorizontalLibrarySection()
            case 1:
                return SectionsFactory.setUpVerticalsection(withHeader: true)
            default:
                return SectionsFactory.setUpHorizontalLibrarySection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}


extension LibraryPlayerViewController: PlaylistCVDelegate{
    func cellTapped(_ model: Playlist) {
        let vc: PlaylistViewController = PlaylistViewController(playlistID: model.id, playlistTitle: model.name , playlistDesc: model.description)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension LibraryPlayerViewController: AlbumCVDelegate{
    func cellTapped(_ model: Album) {
        let vc: AlbumViewController = AlbumViewController(albumID: model.id,albumTitle: model.name,albumAuthor: model.artists.first?.name)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension LibraryPlayerViewController: ArtistCVDelegate{
    func cellTapped(_ model: Artist) {
        let vc: ArtistViewController = ArtistViewController(artistID: model.id, artistTitle: model.name)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
