//
//  LaunchesTableViewDataSource.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 16.10.2022.
//

import UIKit

final class LaunchesDataSource: NSObject, UITableViewDataSource {
    
    var launchesViewData: LaunchesViewData?
    
    private let launchSuccessImage = UIImage(named: "rocketUp")
    private let launchFailureImage = UIImage(named: "rocketDown")
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewData = launchesViewData else { return 0 }
        return viewData.launches.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LaunchCell.cellId,for: indexPath) as? LaunchCell,
              let launch = launchesViewData?.launches[indexPath.section]
        else {
            return UITableViewCell()
        }
        
        let iconImage = launch.isSuccess ? launchSuccessImage : launchFailureImage
        cell.configure(title: launch.title, date: launch.date, image: iconImage)
    
        return cell
    }
}
