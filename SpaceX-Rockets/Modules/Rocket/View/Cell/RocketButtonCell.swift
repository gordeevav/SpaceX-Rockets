//
//  RocketButttonCell.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 26.09.2022.
//

import UIKit

final class PassableButton: UIButton {
    var params = [String: String]()
}

// MARK: RocketButtonCell
final class RocketButtonCell: UICollectionViewCell {
    
    public lazy var button = PassableButton() .. {
        addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            $0.topAnchor.constraint(equalTo: topAnchor),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor),
            $0.leftAnchor.constraint(equalTo: leftAnchor),
            $0.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
