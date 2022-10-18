//
//  RocketLayout.swift
//  SpaceX-Rockets
//
//  Created by Александр on 13.09.2022.
//

import UIKit

struct RocketLayout {
    
    struct Const {
        static let mainLeftMargin: CGFloat = 32
        static let mainRightMargin: CGFloat = -32
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = RocketViewSection(rawValue: sectionIndex) else { return nil }
            
            switch section {
            case .image:            return makeImageSection()
            case .rocketTitle:      return makeRocketTitleSection()
            case .properties:       return makePropertiesSection()
            case .firstFlight:      return makeFirstFlightSection()
            case .firstStage:       return makeStageSection()
            case .secondStage:      return makeStageSection()
            case .launchButton:     return makeLaunchButtonSection()
            }
        }
        
        return layout
    }
    
    private func makeImageSection() -> NSCollectionLayoutSection {
        let item = layoutItem(width: .fractionalWidth(1.0), height: .fractionalHeight(1.0))
        
        let groupSize = layoutSize(width: .fractionalWidth(1.0), height: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        return NSCollectionLayoutSection(group: group)
    }
        
    private func makeRocketTitleSection() -> NSCollectionLayoutSection {
        let titleItem = layoutItem(width: .fractionalWidth(0.8), height: .fractionalHeight(1.0))
        let buttonItem = layoutItem(width: .fractionalWidth(0.2), height: .fractionalHeight(1.0))
        
        let groupSize = layoutSize(width: .fractionalWidth(1.0), height: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [titleItem, buttonItem])
        group.contentInsets = .init(top: 0, leading: Const.mainLeftMargin, bottom: 10, trailing: Const.mainLeftMargin)

        return NSCollectionLayoutSection(group: group)
    }
    
    private func makePropertiesSection() -> NSCollectionLayoutSection {
        let item = layoutItem(width: .absolute(102.0), height: .absolute(102.0))
        item.contentInsets = .init(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let groupSize = layoutSize(width: .estimated(102.0 * 4.0), height: .absolute(134.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 0, bottom: 24, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func makeFirstFlightSection() -> NSCollectionLayoutSection {
        let titleItem = layoutItem(width: .fractionalWidth(0.6), height: .fractionalHeight(1.0))
        let valueItem = layoutItem(width: .fractionalWidth(0.4), height: .fractionalHeight(1.0))
        
        let groupSize = layoutSize(width: .fractionalWidth(1.0), height: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [titleItem, valueItem])
        group.contentInsets = .init(top: 0, leading: Const.mainLeftMargin, bottom: 0, trailing: Const.mainLeftMargin)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 0)
        return section
    }
    
    private func makeStageSection() -> NSCollectionLayoutSection {
        let titleItem = layoutItem(width: .fractionalWidth(0.7), height: .fractionalHeight(1.0))
        let valueItem = layoutItem(width: .fractionalWidth(0.15), height: .fractionalHeight(1.0))
        let measureItem = layoutItem(width: .fractionalWidth(0.15), height: .fractionalHeight(1.0))
        
        let groupSize = layoutSize(width: .fractionalWidth(1.0), height: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [titleItem, valueItem, measureItem])
        group.contentInsets = .init(top: 0, leading: Const.mainLeftMargin, bottom: 0, trailing: Const.mainLeftMargin)
        
        let headerSize = layoutSize(width: .fractionalWidth(1.0), height: .absolute(64))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading
        )
        headerItem.contentInsets = .init(top: 0, leading: Const.mainLeftMargin, bottom: 0, trailing: Const.mainLeftMargin)
                                        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [headerItem]
        
        return section
    }
    
    private func makeLaunchButtonSection() -> NSCollectionLayoutSection {
        let item = layoutItem(width: .fractionalWidth(1.0), height: .fractionalHeight(1.0))
        
        let groupSize = layoutSize(width: .fractionalWidth(1.0), height: .absolute(136))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .init(top: 40, leading: Const.mainLeftMargin, bottom: 40, trailing: Const.mainLeftMargin)
        
        return NSCollectionLayoutSection(group: group)
    }
    
    private func layoutSize(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension) -> NSCollectionLayoutSize {
        return NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
    }
    
    private func layoutItem(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension) -> NSCollectionLayoutItem {
        let size = layoutSize(width: width, height: height)
        return NSCollectionLayoutItem(layoutSize: size)
    }
}
