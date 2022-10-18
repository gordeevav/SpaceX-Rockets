//
//  SettingsRow.swift
//  SpaceX-Rockets
//
//  Created by Александр on 07.09.2022.
//

import UIKit

// MARK: SettingsRow
final class SettingsRow: UITableViewCell {
    
    static let cellId = "SettingsRow"
    
    private var titleLabel = UILabel()
    private var segmentControl = UISegmentedControl()
    
    var onSelect: ((Int) -> Void)?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: SettingsRow.cellId)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func configure(title: String, values: [String], selectedIndex: Int) {
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
        
        setupTitleLabel()
        setupSegmentControl()
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.textColor = .appLightGray
        titleLabel.font = UIFont.labGrotesqueFontRegular(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupSegmentControl() {
        
        contentView.addSubview(segmentControl)
        
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.backgroundColor = .appDarkGray
        segmentControl.selectedSegmentTintColor = .appWhite
        segmentControl.setTitleTextAttributes(
            [.foregroundColor: UIColor.appGray],
            for: .normal
        )
        segmentControl.setTitleTextAttributes(
            [.foregroundColor: UIColor.appBlack],
            for: .selected
        )
        
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
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
