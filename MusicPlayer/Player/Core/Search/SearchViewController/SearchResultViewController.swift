//
//  SearchViewController.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 05.01.2023.
//

import UIKit

final class SearchResultsViewController : UIViewController, UITableViewDelegate, UITextFieldDelegate{
    private lazy var tableView : UITableView = {
       let table = UITableView()
        table.backgroundColor = .artemisBackground
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        setTableAnchors()
        registerCells()
        setupUI()
        setTableViewDelegate()
    }
    
    private func setTableAnchors(){
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func registerCells(){
        tableView.register(SearchResultSubTableViewCell.self, forCellReuseIdentifier: SearchResultSubTableViewCell.identifier)
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
    }
    
    private func setTableViewDelegate(){
        tableView.delegate  = self
        tableView.dataSource = self
    }
    
    private func setupUI(){
        navigationItem.title = AuthStrings.title
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 90
    }
    
}

extension SearchResultsViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as! SearchResultTableViewCell
            cell.selectionStyle = .none
            cell.contentView.layoutMargins = .init(top: 5, left: 10, bottom: 5, right: 10)
            cell.configure()
            return cell
        default:
            let cell: SearchResultSubTableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubTableViewCell.identifier, for: indexPath) as! SearchResultSubTableViewCell
            cell.selectionStyle = .none
            cell.contentView.layoutMargins = .init(top: 5, left: 10, bottom: 5, right: 10)
            cell.configure()
            return cell
        }
    }
}
