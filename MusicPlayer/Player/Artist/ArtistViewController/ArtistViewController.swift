//
//  ArtistViewController.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 08.01.2023.
//

import UIKit

final class ArtistViewController: UIViewController, UICollectionViewDelegate{
    private let viewModel: ArtistViewModel
    private let headers: [SectionHeaderType] = [.header,.albums,.tracks]
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.backgroundColor = .artemisBackground
        cv.isPagingEnabled = false //fixes the bug with group scroll
        return cv
    }()
    
    init(artistID: String, artistTitle: String?) {
        let authorName: String = artistTitle ?? ""
        self.viewModel = ArtistViewModel(artistID: artistID, ArtistTitle: authorName)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData(collection: self.collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
        
        collectionView.register(CollectionCellType.album.cellClass, forCellWithReuseIdentifier: CollectionCellType.album.cellIdentifier)
        
        collectionView.register(CollectionCellType.track.cellClass, forCellWithReuseIdentifier: CollectionCellType.track.cellIdentifier)
        
        collectionView.register(HeaderType.sectionHeader.headerClass, forSupplementaryViewOfKind: HeaderType.sectionHeader.headerKinds, withReuseIdentifier: HeaderType.sectionHeader.headerIdentifier)
        
        collectionView.register(HeaderType.artist.headerClass, forCellWithReuseIdentifier: HeaderType.artist.headerIdentifier)
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
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupBackground(){
        let background = UIImage(named: Images.playerBackgroundImage)
        
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        collectionView.backgroundColor = .artemisBackgroundTransperent
    }
}

extension ArtistViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return viewModel.AlbumSource.count
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
            let headerView = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderType.artist.headerIdentifier, for: indexPath) as! ArtistHeader
            headerView.configure(header: ArtistHeaderModel(title: viewModel.getArtistName(), cover: viewModel.getCover()))
            headerView.setUpDelegate(delegate: self)
            return headerView
        case 1:
            let cell: AlbumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellType.album.cellIdentifier, for: indexPath) as! AlbumCollectionViewCell
            cell.configure(album: viewModel.AlbumSource[indexPath.row])
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


extension ArtistViewController{
    private func setUpLayout(){
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0:
                return SectionsFactory.setUpArtistHeader()
            case 1:
                return SectionsFactory.setUpVerticalsection(withHeader: true)
            default:
                return SectionsFactory.setUpVerticalsection(withHeader: true)
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension ArtistViewController: ArtistHeaderDelegate{
    func playerControlViewDidTapLikeButton(_ artistHeader: ArtistHeader) {
    }
    
}

extension ArtistViewController: MusicTrackCVDelegate{
    func cellTapped(_ model: Track) {
        let vc: MusicPlayerViewController = MusicPlayerViewController(trackID: model.id,trackTitle: model.name,trackAuthor: model.artists.first?.name,audio: URL(string: model.preview_url ?? ""))
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ArtistViewController: AlbumCVDelegate{
    func cellTapped(_ model: Album) {
        let vc: AlbumViewController = AlbumViewController(albumID: model.id,albumTitle: model.name,albumAuthor: model.artists.first?.name)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
