//
//  SettingsRow.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 07.09.2022.
//

import UIKit

// MARK: SettingsRow
final class SettingsRow: UITableViewCell {
    
    static let cellId = "SettingsRow"
    
    private lazy var titleLabel = UILabel() .. {
        contentView.addSubview($0)
        
        $0.textColor = .appLightGray
        $0.font = UIFont.labGrotesqueFontRegular(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var segmentControl = UISegmentedControl() .. {
        contentView.addSubview($0)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .appDarkGray
        $0.selectedSegmentTintColor = .appWhite
        $0.setTitleTextAttributes(
            [.foregroundColor: UIColor.appGray],
            for: .normal
        )
        $0.setTitleTextAttributes(
            [.foregroundColor: UIColor.appBlack],
            for: .selected
        )
        
        $0.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
    }
    
    var onSelect: ((Int) -> Void)?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: SettingsRow.cellId)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    public func configure(title: String, values: [String], selectedIndex: Int) {
        titleLabel.text = title
        segmentControl.setItems(values)
        segmentControl.selectedSegmentIndex = selectedIndex
        
        relayout()
    }
}

// MARK: Setup UI Methods
extension SettingsRow {
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    @objc func segmentControlValueChanged() {
        onSelect?(segmentControl.selectedSegmentIndex)
    }
        
    private func relayout() {
        for index in 0 ..< segmentControl.numberOfSegments {
            segmentControl.setWidth(56, forSegmentAt: index)
        }
        
        segmentControl.sizeToFit()
        titleLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.frame.height),
            
            segmentControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            segmentControl.rightAnchor.constraint(equalTo: rightAnchor),
            segmentControl.widthAnchor.constraint(equalToConstant: segmentControl.frame.width),
            segmentControl.heightAnchor.constraint(equalToConstant: segmentControl.frame.height)
        ])
    }
}
