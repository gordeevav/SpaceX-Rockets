//
//  RocketViewData.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 30.08.2022.
//

import UIKit

typealias RocketViewDataSnapshot = NSDiffableDataSourceSnapshot<RocketViewSection, RocketViewDataItem>
typealias RocketViewDataSource = UICollectionViewDiffableDataSource<RocketViewSection, RocketViewDataItem>

// MARK: RocketViewData
final class RocketViewData {
    private let numberFormatter: RocketNumberFormatter
    private let dateFormatter: RocketDateFormatter
            
    private let rocketApiData: RocketApiData
    private let placeholderImage = UIImage(named: "rocket")
    
    public var rocketId: String { return rocketApiData.id ?? "" }
    public var randomImageUrl: String {
        guard let imageUrls = rocketApiData.flickrImages, imageUrls.count > 0 else { return "" }
        let randomIndex = Int.random(in: 0 ... imageUrls.count - 1)
        return imageUrls[randomIndex]
    }
    
    init(apiData: RocketApiData, numberFormatter: RocketNumberFormatter, dateFormatter: RocketDateFormatter) {
        self.rocketApiData = apiData
        self.numberFormatter = numberFormatter
        self.dateFormatter = dateFormatter
    }
}

// MARK: Make Snapshot
extension RocketViewData {

    public func makeSnapshot(settingsData: SettingsData) -> RocketViewDataSnapshot {
        var snapshot = RocketViewDataSnapshot()
        
        snapshot.appendSections([.image, .rocketTitle, .properties, .firstFlight, .firstStage, .secondStage, .launchButton])
        
        snapshot.appendItems([RocketViewDataItem(.image(randomImageUrl, placeholderImage))], toSection: .image)
        snapshot.appendItems([
            RocketViewDataItem(.rocketTitle(rocketApiData.name ?? "")),
            RocketViewDataItem(.settingsButton)
        ], toSection: .rocketTitle)
        
        snapshot.appendItems(makeRocketPropertyItems(settingsData: settingsData), toSection: .properties)
        snapshot.appendItems(makeFirstFlightItems(), toSection: .firstFlight)
        
        snapshot.appendItems(makeStageItems(stageData: rocketApiData.firstStage), toSection: .firstStage)
        snapshot.appendItems(makeStageItems(stageData: rocketApiData.secondStage), toSection: .secondStage)
        
        snapshot.appendItems(
            [RocketViewDataItem(.launchButton(rocketApiData.id ?? "", rocketApiData.name ?? ""))],
            toSection: .launchButton
        )
                
        return snapshot
    }
    
    public func makeRocketPropertyItems(settingsData: SettingsData) -> [RocketViewDataItem] {[
        RocketViewDataItem(.property(
            NSLocalizedString("Rocket.Height", comment: "") + " " + settingsData.height.textForRocketPropertyCell,
            numberFormatter.string(from: rocketApiData.height?.value(measure: settingsData.height) ?? 0)
        )),
        RocketViewDataItem(.property(
            NSLocalizedString("Rocket.Diameter", comment: "") + " " + settingsData.diameter.textForRocketPropertyCell,
            numberFormatter.string(from: rocketApiData.diameter?.value(measure: settingsData.diameter) ?? 0)
        )),
        RocketViewDataItem(.property(
            NSLocalizedString("Rocket.Weight", comment: "") + " " + settingsData.weight.textForRocketPropertyCell,
            numberFormatter.string(from: Double(rocketApiData.mass?.value(measure: settingsData.weight) ?? 0))
        )),
        RocketViewDataItem(.property(
            NSLocalizedString("Rocket.Payload Weight For Leo", comment: "") + " " +
            settingsData.payload.textForRocketPropertyCell,
            numberFormatter.string(from: Double(rocketApiData.payload?.value(measure: settingsData.payload) ?? 0))
        ))
    ]}
    
    public func makeFirstFlightItems() -> [RocketViewDataItem] {[
        RocketViewDataItem(.rowTitle(NSLocalizedString("Rocket.First Flight", comment: ""))),
        RocketViewDataItem(.rowValueRegular(dateFormatter.firstFlightString(from: rocketApiData.firstFlight ?? ""))),

        RocketViewDataItem(.rowTitle(NSLocalizedString("Rocket.Country", comment: ""))),
        RocketViewDataItem(.rowValueRegular(NSLocalizedString(rocketApiData.country ?? "", comment: ""))),

        RocketViewDataItem(.rowTitle(NSLocalizedString("Rocket.Cost", comment: ""))),
        RocketViewDataItem(.rowValueRegular(costStringInMillions(from: Double(rocketApiData.costPerLaunch ?? 0))))
    ]}
    
    public func makeStageItems(stageData: RocketApiData.StageData?) -> [RocketViewDataItem] {[
        RocketViewDataItem(.rowTitle(NSLocalizedString("Rocket.Engines", comment: ""))),
        RocketViewDataItem(.rowValueBold(String(stageData?.engines ?? 0))),
        RocketViewDataItem(.rowMeasure(" ")),

        RocketViewDataItem(.rowTitle(NSLocalizedString("Rocket.Fuel Amount", comment: ""))),
        RocketViewDataItem(.rowValueBold(String(stageData?.fuelAmountTons ?? 0))),
        RocketViewDataItem(.rowMeasure(NSLocalizedString("Measure.ton", comment: ""))),
        
        RocketViewDataItem(.rowTitle(NSLocalizedString("Rocket.Burn Time", comment: ""))),
        RocketViewDataItem(.rowValueBold(String(stageData?.burnTimeSec ?? 0))),
        RocketViewDataItem(.rowMeasure(NSLocalizedString("Measure.sec", comment: "")))
    ]}
}

// MARK: Calc Methods
extension RocketViewData {
    private func costStringInMillions(from value: Double) -> String {
        let numberString = numberFormatter.string(from: Double(rocketApiData.costPerLaunch ?? 0) / 1_000_000)
        let millionString = NSLocalizedString("RocketViewData: M", comment: "")
        return "$ \(numberString) \(millionString)"
    }
}
