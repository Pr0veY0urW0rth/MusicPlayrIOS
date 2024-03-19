//
//  FirstScreen.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 01.11.2022.
import UIKit

final class HomePlayerViewController: UIViewController, UICollectionViewDelegate{
    private let viewModel = HomePlayerViewModel()
    private let headers: [SectionHeaderType] = [.header,.artists,.albums,.playlists,.tracks]
    
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.view.addSubview(collectionView)
        setCollectionAnchors()
        registerCells()
        setupUI()
        setCollectionViewDelegate()
        setupBackground()
        setUpLayout()
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
        
        collectionView.register(CollectionCellType.track.cellClass, forCellWithReuseIdentifier: CollectionCellType.track.cellIdentifier)
        
        collectionView.register(HeaderType.sectionHeader.headerClass, forSupplementaryViewOfKind: HeaderType.sectionHeader.headerKinds, withReuseIdentifier: HeaderType.sectionHeader.headerIdentifier)
        
        collectionView.register(HeaderType.homeHeader.headerClass, forCellWithReuseIdentifier: HeaderType.homeHeader.headerIdentifier)
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

extension HomePlayerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return viewModel.ArtistSource.count
        case 2:
            return viewModel.AlbumSource.count
        case 3:
            return viewModel.PlaylistSource.count
        default:
            return viewModel.TrackSource.count
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
            let headerView = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderType.homeHeader.headerIdentifier, for: indexPath) as! HomeHeader
            headerView.setUpDelegate(delegate: self)
            return headerView
        case 1:
            let cell: ArtistCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellType.artist.cellIdentifier, for: indexPath) as! ArtistCollectionViewCell
            cell.configure(artist: viewModel.ArtistSource[indexPath.row])
            cell.setUpDelegate(delegate: self)
            return cell
        case 2:
            let cell: AlbumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellType.album.cellIdentifier, for: indexPath) as! AlbumCollectionViewCell
            cell.configure(album: viewModel.AlbumSource[indexPath.row])
            cell.setUpDelegate(delegate: self)
            return cell
        case 3:
            let cell: PlaylistCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellType.playlist.cellIdentifier, for: indexPath) as! PlaylistCollectionViewCell
            cell.configure(playlist: viewModel.PlaylistSource[indexPath.row])
            cell.setUpDelegate(delegate: self)
            return cell
        default:
            let cell: MusicTrackCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellType.track.cellIdentifier, for: indexPath) as! MusicTrackCollectionViewCell
            cell.configure(track: viewModel.TrackSource[indexPath.row])
            cell.setUpDelegate(delegate: self)
            return cell
        }
    }
}

extension HomePlayerViewController{
    private func setUpLayout(){
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0:
                return SectionsFactory.setUpHeaderSection()
            case 1:
                return SectionsFactory.setUpHorizontalHomeSection()
            case 2 :
                return SectionsFactory.setUpVerticalsection(withHeader: true)
            case 3 :
                return SectionsFactory.setUpHorizontalHomeSection()
            default:
                return SectionsFactory.setUpVerticalsection(withHeader: true)
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension HomePlayerViewController: HomeHeaderDelegate{
    func didTapRecent(_ homeHeader: HomeHeader) {
        let vc = RecentlyPlayedViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapOptions(_ homeHeader: HomeHeader) {
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomePlayerViewController: MusicTrackCVDelegate{
    func cellTapped(_ model: Track) {
        let vc: MusicPlayerViewController = MusicPlayerViewController(trackID: model.id,trackTitle: model.name,trackAuthor: model.artists.first?.name,audio: URL(string: model.preview_url ?? ""))
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomePlayerViewController: PlaylistCVDelegate{
    func cellTapped(_ model: Playlist) {
        
        let vc: PlaylistViewController = PlaylistViewController(playlistID: model.id, playlistTitle: model.name , playlistDesc: model.description)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomePlayerViewController: AlbumCVDelegate{
    func cellTapped(_ model: Album) {
        let vc: AlbumViewController = AlbumViewController(albumID: model.id,albumTitle: model.name,albumAuthor: model.artists.first?.name)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomePlayerViewController: ArtistCVDelegate{
    func cellTapped(_ model: Artist) {
        let vc: ArtistViewController = ArtistViewController(artistID: model.id, artistTitle: model.name)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
