//
//  SearchPlayerViewController.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 21.11.2022.
//

import UIKit

class SearchPlayerViewController: UIViewController, UICollectionViewDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    private let viewModel: SearchPlayerViewModel = SearchPlayerViewModel()
    
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsViewController())
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = PlayerStrings.searchPlaceholder
        return search
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .artemisBackgroundTransperent
        return cv
    }()
    
    override func viewDidLoad() {
        viewModel.fetchData(collection: self.collectionView)
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        self.navigationController?.navigationBar.isTranslucent = true
        navigationItem.searchController = searchController
        setCollectionAnchors()
        registerCells()
        setCollectionViewDelegate()
        setupBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController.searchBar.searchTextField.textColor = .black
    }
    
    private func setCollectionAnchors(){
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func registerCells(){
        collectionView.register(CollectionCellType.category.cellClass, forCellWithReuseIdentifier: CollectionCellType.category.cellIdentifier)
    }
    
    private func setCollectionViewDelegate(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupBackground(){
        let background = UIImage(named: Images.playerBackgroundImage)
        
        let imageView: UIImageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        collectionView.backgroundColor = .artemisBackgroundTransperent
    }
}

extension SearchPlayerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countCategories()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCollectionViewCelll = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellType.category.cellIdentifier, for: indexPath) as! CategoryCollectionViewCelll
        cell.configure(category: viewModel.data()[indexPath.row])
        cell.setUpDelegate(delegate: self)
        return cell
    }
}

extension SearchPlayerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 10, bottom: 0, right: 10)
    }
}

extension SearchPlayerViewController: CategoryCVDelegate{
    func cellTapped(_ model: Category) {
        let vc: CategoryViewController = CategoryViewController(categoryID: model.id, categoryTitle: model.name)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
