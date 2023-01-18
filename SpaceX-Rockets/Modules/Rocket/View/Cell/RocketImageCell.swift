//
//  RocketImageCell.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 12.09.2022.
//

import UIKit

// MARK: RocketImageCell
final class RocketImageCell: UICollectionViewCell {
    
    private lazy var roundedView = UIView() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .appBlack
        $0.layer.cornerRadius = 25
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private lazy var imageView = UIImageView() .. {
        addSubview($0)
        $0.addSubview(roundedView)
        
        $0.contentMode = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            $0.topAnchor.constraint(equalTo: topAnchor, constant: -30),
            $0.leftAnchor.constraint(equalTo: leftAnchor),
            $0.rightAnchor.constraint(equalTo: rightAnchor),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            roundedView.heightAnchor.constraint(equalToConstant: 65),
            roundedView.leftAnchor.constraint(equalTo: $0.leftAnchor),
            roundedView.rightAnchor.constraint(equalTo: $0.rightAnchor),
            roundedView.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: 40)
        ])
    }
    
    public func setImage(_ imageUrl: String, placeholder: UIImage?) {
        imageView.loadAsync(from: imageUrl, placeholder: placeholder)
    }
}
