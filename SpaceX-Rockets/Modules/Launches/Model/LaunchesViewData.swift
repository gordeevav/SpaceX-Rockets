//
//  LaunchesViewData.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 25.08.2022.
//

import UIKit

// MARK: LauncesItem
struct LaunchesItem {
    let title: String
    let date: String
    let isSuccess: Bool
    
    init(launcesApiData: LaunchesApiData, dateFormatter: RocketDateFormatter) {
        title = launcesApiData.name ?? "-/-"
        date = dateFormatter.localizedDateString(dateUnix: launcesApiData.dateUnix ?? 0)
        isSuccess = launcesApiData.success ?? false
    }
}

// MARK: LaunchesViewData
struct LaunchesViewData {
    
    let rocketName: String
    let launches: [LaunchesItem]
    
    init(rocketName: String, launcesApiData: [LaunchesApiData]) {
        self.rocketName = rocketName
        
        let dateFormatter = RocketDateFormatter()
        launches = launcesApiData.map {
            LaunchesItem(launcesApiData: $0, dateFormatter: dateFormatter)        
        }
    }
}
