//
//  LaunchesViewController.swift
//  SpaceX-Rockets
//
//  Created by Александр on 25.08.2022.
//

import UIKit

// MARK: LaunchesViewController
final class LaunchesViewController: UIViewController, LaunchesViewProtocol, LoadingViewProtocol {
    
    var activityIndicatorView = UIActivityIndicatorView()
    var mainView: UIView?
    
    var presenter: LaunchesPresenterProtocol?
    
    let tableView = UITableView()
    var launchesViewData: LaunchesViewData?
    
    let launchSuccessImage = UIImage(named: "rocketUp")
    let launchFailureImage = UIImage(named: "rocketDown")

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupLoadingViews(controllerView: view, mainView: tableView)
        
        view.backgroundColor = .appBlack
    }

    override func viewWillAppear(_ animated: Bool) {
        showNavBar()
    }
    
    func showLaunchesViewData(_ launchesViewData: LaunchesViewData) {
        hideLoading()
        
        self.launchesViewData = launchesViewData
        tableView.reloadData()
    }
}

// MARK: Table DataSource
extension LaunchesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewData = launchesViewData else { return 0 }
        return viewData.launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LaunchCell.cellId, for: indexPath) as? LaunchCell
        else {
            return UITableViewCell()
        }
        
        if let launch = launchesViewData?.launches[indexPath.section] {
            let iconImage = launch.isSuccess ? launchSuccessImage : launchFailureImage
            cell.configure(title: launch.title, date: launch.date, image: iconImage)
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: Table Delegate
extension LaunchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 2 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
}

// MARK: - UI Methods
extension LaunchesViewController {
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.cellId)
        
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        
        let layoutMargins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor, constant: 32),
            tableView.rightAnchor.constraint(equalTo: layoutMargins.rightAnchor, constant: -32),
            tableView.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor)
        ])
    }
    
    private func showNavBar() {
        navigationController?.navigationBar.topItem?.backButtonTitle = NSLocalizedString("Launches.Back", comment: "")
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

