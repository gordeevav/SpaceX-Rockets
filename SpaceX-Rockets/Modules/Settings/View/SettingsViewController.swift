//
//  SettingsViewController.swift
//  SpaceX-Rockets
//
//  Created by Александр on 19.08.2022.
//

import UIKit

// MARK: SettingsViewController
final class SettingsViewController: UIViewController {
    
    var presenter: SettingsPresenterProtocol?
    
    private let tableView = UITableView()
    private var settingsData: SettingsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func dismissButtonDidPress() {
        presenter?.hideSettings()
    }
}

extension SettingsViewController: SettingsViewProtocol {
    public func setSettingsData(_ settingsData: SettingsData) {
        self.settingsData = settingsData
    }
}

// MARK: TableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 4 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = tableView.dequeueReusableCell(
                withIdentifier: SettingsRow.cellId, for: indexPath) as? SettingsRow
        else { return UITableViewCell() }

        switch indexPath.row {
        case SettingsFields.height.rawValue:
            row.configure(
                title: SettingsFields.height.rowTitle,
                values: LenghtMeasurement.allValues(),
                selectedIndex: settingsData?.height.rawValue ?? 0
            )
            row.onSelect = { [weak self] in
                self?.settingsData?.height = LenghtMeasurement(rawValue: $0) ?? LenghtMeasurement.defaultValue
            }
        case SettingsFields.diameter.rawValue:
            row.configure(
                title: SettingsFields.diameter.rowTitle,
                values: LenghtMeasurement.allValues(),
                selectedIndex: settingsData?.diameter.rawValue  ?? 0
            )
            row.onSelect = { [weak self] in
                self?.settingsData?.diameter = LenghtMeasurement(rawValue: $0) ?? LenghtMeasurement.defaultValue
            }
        case SettingsFields.weight.rawValue:
            row.configure(
                title: SettingsFields.weight.rowTitle,
                values: WeightMeasurement.allValues(),
                selectedIndex: settingsData?.weight.rawValue ?? 0
            )
            row.onSelect = { [weak self] in
                self?.settingsData?.weight = WeightMeasurement(rawValue: $0) ?? WeightMeasurement.defaultValue
            }
        case SettingsFields.payloadWeightForLeo.rawValue:
            row.configure(
                title: SettingsFields.payloadWeightForLeo.rowTitle,
                values: WeightMeasurement.allValues(),
                selectedIndex: settingsData?.payload.rawValue ?? 0
            )
            row.onSelect = { [weak self] in
                self?.settingsData?.payload = WeightMeasurement(rawValue: $0) ?? WeightMeasurement.defaultValue
            }
        default:
            row.configure(
                title: "-/-",
                values: [],
                selectedIndex: 0
            )
        }
        return row
    }
}

// MARK: Setup UI Methods
extension SettingsViewController {

    private func setupUI() {
        setupNavigation()
        setupTableView()
    }
    
    private func setupNavigation() {
        title = NSLocalizedString("Settings.Settings", comment: "")
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Settings.Close", comment: ""),
            style: .plain,
            target: self,
            action: #selector(dismissButtonDidPress)
        )
        navigationItem.rightBarButtonItem?.tintColor = .appWhite
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appWhite]
        
        view.backgroundColor = .appBlack
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.register(SettingsRow.self, forCellReuseIdentifier: SettingsRow.cellId)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .appBlack
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
                
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -28)
        ])
    }
    
}
