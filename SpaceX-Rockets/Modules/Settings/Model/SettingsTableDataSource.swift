//
//  SettingsTableDataSource.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 14.10.2022.
//

import UIKit

class SettingsTableDataSource: NSObject, UITableViewDataSource {
    
    var settingsData: SettingsData?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 4 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = tableView.dequeueReusableCell(
                withIdentifier: SettingsRow.cellId,
                for: indexPath) as? SettingsRow
        else { return UITableViewCell() }
        
        guard let field = SettingsFields(rawValue: indexPath.row)
        else { return row }
        
        configure(row: row, for: field)
        row.backgroundColor = .clear
        row.selectionStyle = .none
        
        return row
    }
}

private extension SettingsTableDataSource {
    func configure(row: SettingsRow, for field: SettingsFields) {
        switch field {
        case .height:
            row.configure(
                title: SettingsFields.height.rowTitle,
                values: LenghtMeasurement.allValues(),
                selectedIndex: settingsData?.height.rawValue ?? 0
            )
            row.onSelect = { [weak self] in
                self?.settingsData?.height = LenghtMeasurement(rawValue: $0) ?? LenghtMeasurement.defaultValue
            }
        case .diameter:
            row.configure(
                title: SettingsFields.diameter.rowTitle,
                values: LenghtMeasurement.allValues(),
                selectedIndex: settingsData?.diameter.rawValue  ?? 0
            )
            row.onSelect = { [weak self] in
                self?.settingsData?.diameter = LenghtMeasurement(rawValue: $0) ?? LenghtMeasurement.defaultValue
            }
        case .weight:
            row.configure(
                title: SettingsFields.weight.rowTitle,
                values: WeightMeasurement.allValues(),
                selectedIndex: settingsData?.weight.rawValue ?? 0
            )
            row.onSelect = { [weak self] in
                self?.settingsData?.weight = WeightMeasurement(rawValue: $0) ?? WeightMeasurement.defaultValue
            }
        case .payloadWeightForLeo:
            row.configure(
                title: SettingsFields.payloadWeightForLeo.rowTitle,
                values: WeightMeasurement.allValues(),
                selectedIndex: settingsData?.payload.rawValue ?? 0
            )
            row.onSelect = { [weak self] in
                self?.settingsData?.payload = WeightMeasurement(rawValue: $0) ?? WeightMeasurement.defaultValue
            }
        }
    }
}
