//
//  StackView.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 07.04.2023.
//

import UIKit

extension UIStackView{
    static func makeStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = axis
        stack.spacing = 8.0
        return stack
    }
}
