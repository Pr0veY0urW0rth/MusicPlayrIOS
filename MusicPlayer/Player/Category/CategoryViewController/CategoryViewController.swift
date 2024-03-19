//
//  CategoryViewController.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.01.2023.
//

import UIKit

final class CategoryViewController: UIViewController, UICollectionViewDelegate{
    private let viewModel: CategoryViewModel
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .artemisBackgroundTransperent
        return cv
    }()
    
    init(categoryID: String, categoryTitle: String?) {
        let categoryName: String = categoryTitle ?? ""
        self.viewModel = CategoryViewModel(categoryID: categoryID, categoryTitle: categoryName)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData(collection: self.collectionView)
        self.view.addSubview(collectionView)
        setCollectionAnchors()
        registerCells()
        setCollectionViewDelegate()
        setupBackground()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setCollectionAnchors(){
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func registerCells(){
        collectionView.register(CollectionCellType.playlist.cellClass, forCellWithReuseIdentifier: CollectionCellType.playlist.cellIdentifier)
    }
    
    private func setCollectionViewDelegate(){
        collectionView.delegate = self
        collectionView.dataSource = self
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
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getData().count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PlaylistCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellType.playlist.cellIdentifier, for: indexPath) as! PlaylistCollectionViewCell
        cell.configure(playlist: viewModel.getData()[indexPath.row])
        cell.setUpDelegate(delegate: self)
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 25, right: 10)
    }
}

extension CategoryViewController: PlaylistCVDelegate{
    func cellTapped(_ model: Playlist) {
        
        let vc: PlaylistViewController = PlaylistViewController(playlistID: model.id, playlistTitle: model.name , playlistDesc: model.description)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
