//
//  RocketButttonCell.swift
//  SpaceX-Rockets
//
//  Created by Александр on 26.09.2022.
//

import UIKit

final class PassableButton: UIButton {
    var params = [String: String]()
}

// MARK: RocketButtonCell
final class RocketButtonCell: UICollectionViewCell {
    
    let button = PassableButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leftAnchor.constraint(equalTo: leftAnchor),
            button.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
