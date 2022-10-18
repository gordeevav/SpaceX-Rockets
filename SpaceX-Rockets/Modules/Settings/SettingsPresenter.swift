//
//  SettingsPresenter.swift
//  SpaceX-Rockets
//
//  Created by Александр on 24.08.2022.
//

import Foundation

// MARK: SettingsPresenter
final class SettingsPresenter: SettingsPresenterProtocol {
    
    private let view: SettingsViewProtocol
    private let router: RouterProtocol
    
    required init(view: SettingsViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.view.setSettingsData(SettingsData())
    }
    
    func hideSettings() {
        router.hideSettings()
        
        NotificationCenter.default.post(
            name: NSNotification.Name(SettingsData.settingsDidChange),
            object: nil
        )
    }
}
