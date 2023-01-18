//
//  RocketDataViewController.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 08.09.2022.
//

import UIKit

// MARK: RocketDataViewController
final class RocketViewController: UIViewController {
    
    private var rocketCellRegistration: RocketCellRegistration!
    
    private lazy var collectionView: UICollectionView = {
        let layoutFactory = RocketLayout()
        let collectionViewLayout = layoutFactory.makeLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        return collectionView
    }()

    private lazy var dataSource: RocketViewDataSource? = {
        let dataSource = RocketViewDataSource(collectionView: collectionView) {
            [weak self] collectionView, indexPath, rocketItem in
                
            guard let rocketSection = RocketViewSection(rawValue: indexPath.section)
            else { return UICollectionViewCell() }
            
            return self?.rocketCellRegistration.getCell(for: rocketSection, collectionView: collectionView,
                                 indexPath: indexPath, item: rocketItem)
        }
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, _, indexPath in
            guard let sectionHeaderCellRegistration = self?.rocketCellRegistration.stageHeaderCellRegistration
            else { return UICollectionViewCell() }
            
            return collectionView.dequeueConfiguredReusableSupplementary(
                using: sectionHeaderCellRegistration, for: indexPath)
        }
        
        return dataSource
    }()
    
    public var rocketButtonsDelegate: RocketButtonsDelegateProtocol?
    
    public var snapshot: RocketViewDataSnapshot? {
        didSet {
            guard let snapshot = self.snapshot else { return }
            dataSource?.applySnapshotUsingReloadData(snapshot)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rocketCellRegistration = RocketCellRegistration(buttonDelegate: self)
        view.backgroundColor = .appBlack
    }
}

// MARK: RocketButtonsDelegateProtocol
extension RocketViewController: RocketButtonsDelegateProtocol {
    
    func settingsButtonDidPress() {
        rocketButtonsDelegate?.settingsButtonDidPress()
    }
    
    func launschesButtonDidPress(rocketId: String, rocketName: String) {
        rocketButtonsDelegate?.launschesButtonDidPress(rocketId: rocketId, rocketName: rocketName)
    }
}
