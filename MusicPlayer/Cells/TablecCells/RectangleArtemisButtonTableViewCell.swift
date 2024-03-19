//
//  RectangleArtemisButtonTableViewCell.swift
//  MusicPlayer
//
//  Created by  User on 25.05.2023.
//

import UIKit

final class RectangleArtemisButtonTableViewCell: UITableViewCell, TableCell{
    weak var delegate: ButtonDelegate?
    
    
}

extension RectangleArtemisButtonTableViewCell:TableViewCell{
    var cellReuseIdentifier: String{
        return CellsIndetifiers.rectangleButton
    }
    
    func configureCell(type: CellType, text: String, state: State) {
        
    }
    
    func setup(delegate: TableCellDelegate) {
        self.delegate = delegate as? any ButtonDelegate
    }
}
