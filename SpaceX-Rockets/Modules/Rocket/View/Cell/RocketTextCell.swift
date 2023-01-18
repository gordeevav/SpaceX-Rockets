//
//  RocketTextCell.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 26.09.2022.
//

import UIKit

// MARK: RocketTextCell
final class RocketTextCell: UICollectionViewCell {
    
    public lazy var label = UILabel() .. {
        addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            $0.topAnchor.constraint(equalTo: topAnchor),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor),
            $0.leftAnchor.constraint(equalTo: leftAnchor),
            $0.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
