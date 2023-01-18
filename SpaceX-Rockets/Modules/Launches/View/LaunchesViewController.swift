//
//  LaunchesViewController.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 25.08.2022.
//

import UIKit

final class LaunchesViewController: UIViewController, LaunchesViewProtocol, LoadingViewProtocol {
    
    var activityIndicatorView = UIActivityIndicatorView()
    var mainView: UIView?
    
    var presenter: LaunchesPresenterProtocol?
    
    private let dataSource = LaunchesDataSource()
    
    private lazy var tableView = UITableView() .. {
        view.addSubview($0)
        
        $0.dataSource = dataSource
        $0.delegate = self
        $0.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.cellId)
        
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.separatorStyle = .none
        $0.rowHeight = 80
        
        NSLayoutConstraint.activate([
            $0.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 32),
            $0.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -32),
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLoadingViews(controllerView: view, mainView: tableView)
        
        view.backgroundColor = .appBlack
        navigationController?.navigationBar.topItem?.backButtonTitle = NSLocalizedString("Launches.Back", comment: "")
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func showLaunchesViewData(_ launchesViewData: LaunchesViewData) {
        hideLoading()
        
        dataSource.launchesViewData = launchesViewData
        tableView.reloadData()
    }
}

// MARK: Table Delegate
extension LaunchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 2 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView() .. { $0.backgroundColor = .clear }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
}
