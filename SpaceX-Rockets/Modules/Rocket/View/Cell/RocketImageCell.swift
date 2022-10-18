//
//  RocketImageCell.swift
//  SpaceX-Rockets
//
//  Created by Александр on 12.09.2022.
//

import UIKit

// MARK: RocketImageCell
final class RocketImageCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
}

// MARK: Setup UI
private extension RocketImageCell {
    
    func setupUI() {
        backgroundColor = .clear
                
        setupImageView()
        setupRoundedView()
    }
    
    func setupImageView() {
        addSubview(imageView)
        clipsToBounds = true
        
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: -30),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupRoundedView() {
        let roundedView = UIView()
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.backgroundColor = .appBlack
        roundedView.layer.cornerRadius = 25
        roundedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        imageView.addSubview(roundedView)
        
        NSLayoutConstraint.activate([
            roundedView.heightAnchor.constraint(equalToConstant: 65),
            roundedView.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            roundedView.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            roundedView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40)
        ])
    }
}
