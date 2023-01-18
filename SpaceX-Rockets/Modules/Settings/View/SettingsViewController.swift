//
//  SettingsViewController.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 19.08.2022.
//

import UIKit

// MARK: SettingsViewController
final class SettingsViewController: UIViewController {
    
    public var presenter: SettingsPresenterProtocol?
    
    private let settingsDataSource = SettingsTableDataSource()
    
    private lazy var tableView = UITableView() .. {
        view.addSubview($0)
                
        $0.register(SettingsRow.self, forCellReuseIdentifier: SettingsRow.cellId)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .appBlack
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
                
        NSLayoutConstraint.activate([
            $0.topAnchor.constraint(equalTo: view.topAnchor),
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28),
            $0.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -28)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBlack
        title = NSLocalizedString("Settings.Settings", comment: "")
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Settings.Close", comment: ""),
            style: .plain,
            target: self,
            action: #selector(dismissButtonDidPress)
        ) .. {
            $0.tintColor = .appWhite
        }
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appWhite]
        
        tableView.dataSource = settingsDataSource
    }
    
    @objc
    private func dismissButtonDidPress() {
        presenter?.hideSettings()
    }
}

extension SettingsViewController: SettingsViewProtocol {
    public func setSettingsData(_ settingsData: SettingsData) {
        settingsDataSource.settingsData = settingsData
    }
}

