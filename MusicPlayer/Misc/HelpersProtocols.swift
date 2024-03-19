//
//  HelpersProtocols.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 08.01.2023.
//

import UIKit

//cells
protocol TableCellDelegate: AnyObject {}

protocol TableViewCell{
    var cellReuseIdentifier: String { get }
    func configureCell(type: CellType,text: String,state: State)
    func setup(delegate: TableCellDelegate)
}

protocol TableCell: UITableViewCell,TableViewCell{}

//headers
protocol HeaderDelegate: AnyObject {}

protocol Header{
    func setUpDelegate(delegate: HeaderDelegate)
}

//player

protocol PlayerItemsDelegate: AnyObject {}

protocol PlayerItem{
    func setUpDelegate(delegate: PlayerItemsDelegate)
}

protocol Background{
    func setUpBackground(imageName: String)
}
