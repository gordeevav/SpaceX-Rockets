//
//  RocketPropertyCell.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 18.08.2022.
//

import UIKit

// MARK: RocketPropertyCell
final class RocketPropertyCell: UICollectionViewCell {
            
    private lazy var valueLabel = UILabel() .. {
        addSubview($0)
        
        $0.font = UIFont.labGrotesqueFontRegular(ofSize: 14)
        $0.textColor = .appWhite
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
                
        NSLayoutConstraint.activate([
            $0.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            $0.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            $0.centerXAnchor.constraint(equalTo: centerXAnchor),
            $0.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10)
        ])
    }
    
    private lazy var measureLabel = UILabel() .. {
        addSubview($0)
        
        $0.font = UIFont.labGrotesqueFontRegular(ofSize: 13)
        $0.textColor = .appGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        
        NSLayoutConstraint.activate([
            $0.widthAnchor.constraint(equalTo: widthAnchor),
            $0.heightAnchor.constraint(equalToConstant: 24),
            $0.centerXAnchor.constraint(equalTo: centerXAnchor),
            $0.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 12)
        ])
    }
    
    public func configure(valueText: String, measureText: String) {
        valueLabel.text = valueText
        measureLabel.text = measureText
    }
}
