//
//  LaunchCell.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 25.08.2022.
//

import UIKit

// MARK: LaunchCell
final class LaunchCell: UITableViewCell {
    
    static let cellId = "LaunchCell"

    private lazy var titleLabel = UILabel() .. {
        addSubview($0)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .appWhite
        $0.font = UIFont.labGrotesqueFontRegular(ofSize: 16)
        
        NSLayoutConstraint.activate([
            $0.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            $0.rightAnchor.constraint(equalTo: rocketImageView.leftAnchor, constant: -5),
            $0.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            $0.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private lazy var dateLabel = UILabel() .. {
        addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .appGray
        $0.font = UIFont.labGrotesqueFontRegular(ofSize: 16)
        
        NSLayoutConstraint.activate([
            $0.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            $0.rightAnchor.constraint(equalTo: rocketImageView.leftAnchor, constant: -5),
            $0.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            $0.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private lazy var rocketImageView = UIImageView() .. {
        addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            $0.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            $0.centerYAnchor.constraint(equalTo: centerYAnchor),
            $0.widthAnchor.constraint(equalToConstant: 30),
            $0.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func configure(title: String, date: String, image: UIImage?) {
        titleLabel.text = title
        dateLabel.text = date
        rocketImageView.image = image
    }
}

// MARK: Setup UI Methods
private extension LaunchCell {

    func setupUI() {
        selectionStyle = .none
        layer.cornerRadius = 24
        backgroundColor = .appDarkGray
    }
}
