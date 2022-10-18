//
//  LaunchesViewData.swift
//  SpaceX-Rockets
//
//  Created by Александр on 25.08.2022.
//

import UIKit

// MARK: LauncesItem
struct LaunchesItem {
    let title: String
    let date: String
    let isSuccess: Bool
    
    init(launcesApiData: LaunchesApiData) {
        title = launcesApiData.name ?? "-/-"
        date = launcesApiData.date
        isSuccess = launcesApiData.success ?? false
    }
}

// MARK: LaunchesViewData
struct LaunchesViewData {
    
    let rocketName: String
    let launches: [LaunchesItem]
    
    init(rocketName: String, launcesApiData: [LaunchesApiData]) {
        self.rocketName = rocketName
        launches = launcesApiData.map { LaunchesItem(launcesApiData: $0) }
    }
}
