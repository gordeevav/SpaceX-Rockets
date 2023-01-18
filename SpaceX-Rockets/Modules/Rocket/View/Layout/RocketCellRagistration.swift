//
//  RocketCellRagistration.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 13.09.2022.
//

import UIKit

protocol RocketButtonsDelegateProtocol: AnyObject {
    func settingsButtonDidPress()
    func launschesButtonDidPress(rocketId: String, rocketName: String)
}

typealias RocketItemCellRegistration = UICollectionView.CellRegistration<RocketTextCell, String>

final class RocketCellRegistration {
    
    enum ParamNames: String {
        case rocketName
        case rocketId
    }
    
    private var settingsButtonCellRegistration: UICollectionView.CellRegistration<RocketButtonCell, Bool>!
    private var launchButtonCellRegistration:
        UICollectionView.CellRegistration<RocketButtonCell, (rocketId: String, rocketName: String)>!
    
    private let imageCellRegistration =
        UICollectionView.CellRegistration<RocketImageCell, UIImage?> { cell, _, image in
            
        cell.setImage(image)
        cell.backgroundColor = .clear
        cell.clipsToBounds = true
    }
    
    private let rocketHeaderCellRegistration =
        UICollectionView.CellRegistration<RocketTextCell, String> { cell, _, value in
                        
        cell.label.text = value
        cell.label.textColor = .appWhite
        cell.label.font = .labGrotesqueFontRegular(ofSize: 20)
    }
        
    private let propertyCellRegistration =
        UICollectionView.CellRegistration<RocketPropertyCell, (value: String, measure: String)> { cell, _, data in
            cell.configure(valueText: data.value, measureText: data.measure)
            cell.backgroundColor = .appDarkGray
            cell.layer.cornerRadius = 25
    }
    
    private let rowTitleCellRegistration = RocketItemCellRegistration { cell, _, value in
        cell.label.text = value
        cell.label.textColor = .appGray
        cell.label.font = .labGrotesqueFontRegular(ofSize: 16)
    }
    
    private let rowValueRegularCellRegistration = RocketItemCellRegistration { cell, _, value in
        cell.label.text = value
        cell.label.textColor = .appWhite
        cell.label.font = .labGrotesqueFontRegular(ofSize: 16)
        cell.label.textAlignment = .right
    }
    
    private let rowValueBoldCellRegistration = RocketItemCellRegistration { cell, _, value in
        cell.label.text = value
        cell.label.textColor = .appWhite
        cell.label.font = .labGrotesqueFontBold(ofSize: 16)
        cell.label.textAlignment = .right
    }
    
    private let rowMeasureCellRegistration = RocketItemCellRegistration { cell, _, value in
        cell.label.text = value
        cell.label.textColor = .appGray
        cell.label.font = .labGrotesqueFontRegular(ofSize: 16)
        cell.label.textAlignment = .right
    }
    
    let stageHeaderCellRegistration = UICollectionView.SupplementaryRegistration<RocketTextCell>(
        elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, _, indexPath in
        
        supplementaryView.label.textColor = .appWhite
        supplementaryView.label.font = .labGrotesqueFontBold(ofSize: 16)
        
        if indexPath.section == RocketViewSection.firstStage.rawValue {
            supplementaryView.label.text = NSLocalizedString("Rocket.First Stage", comment: "")
        }
        
        if indexPath.section == RocketViewSection.secondStage.rawValue {
            supplementaryView.label.text = NSLocalizedString("Rocket.Secong Stage", comment: "")
        }
    }

    private var buttonDelegate: RocketButtonsDelegateProtocol
    
    init(buttonDelegate: RocketButtonsDelegateProtocol) {
        self.buttonDelegate = buttonDelegate
    }
    
    func setup() {
        settingsButtonCellRegistration = .init { [weak self] cell, _, _ in
            guard let self = self else { return }
            
            let settingsButtonConfig = UIImage.SymbolConfiguration(pointSize: 32)
            
            let button = cell.button
            
            button.setImage(UIImage(systemName: "gearshape", withConfiguration: settingsButtonConfig), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tintColor = .appLightGray
            button.addTarget(self, action: #selector(self.settingsButtonDidPress), for: .touchDown)
        }
        
        launchButtonCellRegistration = .init { cell, _, value in
            let button = cell.button
            
            button.setTitle(NSLocalizedString("Rocket.Show Launches", comment: ""), for: .normal)
            
            button.backgroundColor = .appDarkGray
            button.tintColor = .appLightGray
            button.layer.cornerRadius = 20
            button.titleLabel?.font = .labGrotesqueFontRegular(ofSize: 18)
            button.params[ParamNames.rocketId.rawValue] = value.rocketId
            button.params[ParamNames.rocketName.rawValue] = value.rocketName
            button.addTarget(self, action: #selector(self.launschesButtonDidPress(_:)), for: .touchUpInside)
        }
    }
    
    func getCell(
        for rocketSection: RocketViewSection, collectionView: UICollectionView,
        indexPath: IndexPath, item: RocketViewDataItem
    ) -> UICollectionViewCell {
        
        switch item.data {
        case .image(let image):
            return collectionView.dequeueConfiguredReusableCell(
                using: imageCellRegistration, for: indexPath, item: image
            )
        case .rocketTitle(let value):
            return collectionView.dequeueConfiguredReusableCell(
                using: rocketHeaderCellRegistration, for: indexPath, item: value
            )
        case .settingsButton:
            return collectionView.dequeueConfiguredReusableCell(
                using: settingsButtonCellRegistration, for: indexPath, item: false
            )
        case .property(let value, let measure):
            return collectionView.dequeueConfiguredReusableCell(
                using: propertyCellRegistration, for: indexPath, item: (value: value, measure: measure)
            )
        case .rowMeasure(let value):
            return collectionView.dequeueConfiguredReusableCell(
                using: rowMeasureCellRegistration, for: indexPath, item: value
            )
        case .rowTitle(let value):
            return collectionView.dequeueConfiguredReusableCell(
                using: rowTitleCellRegistration, for: indexPath, item: value
            )
        case .rowValueBold(let value):
            return collectionView.dequeueConfiguredReusableCell(
                using: rowValueBoldCellRegistration, for: indexPath, item: value
            )
        case .rowValueRegular(let value):
            return collectionView.dequeueConfiguredReusableCell(
                using: rowValueRegularCellRegistration, for: indexPath, item: value
            )
        case .launchButton(let rocketId, let rocketName):
            return collectionView.dequeueConfiguredReusableCell(
                using: launchButtonCellRegistration, for: indexPath, item: (rocketId, rocketName)
            )
        }
    }
 
    @objc private func settingsButtonDidPress() {
        buttonDelegate.settingsButtonDidPress()
    }
    
    @objc private func launschesButtonDidPress(_ sender: PassableButton) {
        buttonDelegate.launschesButtonDidPress(
            rocketId: sender.params[ParamNames.rocketId.rawValue] ?? "",
            rocketName: sender.params[ParamNames.rocketName.rawValue] ?? ""
        )
    }
}
