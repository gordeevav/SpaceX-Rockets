//
//  LaunchCell.swift
//  SpaceX-Rockets
//
//  Created by Александр on 25.08.2022.
//

import UIKit

// MARK: LaunchCell
final class LaunchCell: UITableViewCell {
    
    static let cellId = "LaunchCell"

    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let rocketImageView = UIImageView()

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
        setupCell()
        
        setupRocketImageView()
        setupTitleLabel()
        setupDateLabel()
    }
    
    func setupCell() {
        selectionStyle = .none
        layer.cornerRadius = 24
        backgroundColor = .appDarkGray
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .appWhite
        titleLabel.font = UIFont.labGrotesqueFontRegular(ofSize: 16)
        
        let layoutMargins = self
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rocketImageView.leftAnchor, constant: -5),
            titleLabel.centerYAnchor.constraint(equalTo: layoutMargins.centerYAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .appGray
        dateLabel.font = UIFont.labGrotesqueFontRegular(ofSize: 16)
        
        let layoutMargins = self
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor, constant: 20),
            dateLabel.rightAnchor.constraint(equalTo: rocketImageView.leftAnchor, constant: -5),
            dateLabel.centerYAnchor.constraint(equalTo: layoutMargins.centerYAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupRocketImageView() {
        addSubview(rocketImageView)
        rocketImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let layoutMargins = self
        NSLayoutConstraint.activate([
            rocketImageView.rightAnchor.constraint(equalTo: layoutMargins.rightAnchor, constant: -10),
            rocketImageView.centerYAnchor.constraint(equalTo: layoutMargins.centerYAnchor),
            rocketImageView.widthAnchor.constraint(equalToConstant: 30),
            rocketImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
