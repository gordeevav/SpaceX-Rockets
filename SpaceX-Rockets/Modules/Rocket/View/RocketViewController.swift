//
//  RocketDataViewController.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 08.09.2022.
//

import UIKit

// MARK: RocketDataViewController
final class RocketViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var rocketCellRegistration: RocketCellRegistration!
    private var dataSource: RocketViewDataSource?
    private var snapshot: RocketViewDataSnapshot?
    
    var rocketButtonsDelegate: RocketButtonsDelegateProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCellRegistration()
        setupCollectionView()
        setupDataSource()
        
        showSnapshot()
    }
    
    func setSnapshot(_ snapshot: RocketViewDataSnapshot) {
        self.snapshot = snapshot
        showSnapshot()
    }
    
    private func showSnapshot() {
        guard let snapshot = self.snapshot else { return }
        dataSource?.applySnapshotUsingReloadData(snapshot)
    }
}

// MARK: Setup
private extension RocketViewController {
    
    func setupView() {
        view.backgroundColor = .appBlack
    }
    
    func setupCellRegistration() {
        rocketCellRegistration = RocketCellRegistration(buttonDelegate: self)
    }
    
    func setupCollectionView() {
        let layoutFactory = RocketLayout()
        let collectionViewLayout = layoutFactory.makeLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
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
    }
    
    private func setupDataSource() {
        dataSource = RocketViewDataSource(collectionView: collectionView) {
            [weak self] collectionView, indexPath, rocketItem in
                
            guard let rocketSection = RocketViewSection(rawValue: indexPath.section)
            else { return UICollectionViewCell() }
            
            return self?.rocketCellRegistration.getCell(for: rocketSection, collectionView: collectionView,
                                 indexPath: indexPath, item: rocketItem)
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, _, indexPath in
            guard let sectionHeaderCellRegistration = self?.rocketCellRegistration.stageHeaderCellRegistration
            else { return UICollectionViewCell() }
            
            return collectionView.dequeueConfiguredReusableSupplementary(
                using: sectionHeaderCellRegistration, for: indexPath)
        }
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
