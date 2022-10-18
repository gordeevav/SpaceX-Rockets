//
//  RocketPropertyCell.swift
//  SpaceX-Rockets
//
//  Created by Александр on 18.08.2022.
//

import UIKit

// MARK: RocketPropertyCell
final class RocketPropertyCell: UICollectionViewCell {
            
    private let valueLabel = UILabel()
    private let measureLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func configure(valueText: String, measureText: String) {
        valueLabel.text = valueText
        measureLabel.text = measureText
    }
}

// MARK: Setup UI Methods
extension RocketPropertyCell {
    
    private func setupUI() {
        setupCell()
        setupValueLabel()
        setupMeasureLabel()
    }
    
    private func setupCell() {
        backgroundColor = .appDarkGray
        layer.cornerRadius = 25
    }
    
    private func setupValueLabel() {
        addSubview(valueLabel)
        
        valueLabel.font = UIFont.labGrotesqueFontRegular(ofSize: 16)
        valueLabel.textColor = .appWhite
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.textAlignment = .center
                
        NSLayoutConstraint.activate([
            valueLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            valueLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10)
        ])
    }
    
    private func setupMeasureLabel() {
        addSubview(measureLabel)
        
        measureLabel.font = UIFont.labGrotesqueFontRegular(ofSize: 14)
        measureLabel.textColor = .appGray
        measureLabel.translatesAutoresizingMaskIntoConstraints = false
        measureLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            measureLabel.widthAnchor.constraint(equalTo: widthAnchor),
            measureLabel.heightAnchor.constraint(equalToConstant: 24),
            measureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            measureLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 12)
        ])
    }
}
