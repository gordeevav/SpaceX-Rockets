//
//  ErrorViewController.swift
//  SpaceX-Rockets
//
//  Created by Александр on 31.08.2022.
//

import UIKit

// MARK: ErrorViewController
final class ErrorViewController: UIViewController, ErrorViewProtocol {
    
    private let label = UILabel()
    private let closeButton = UIButton()
    
    var presenter: ErrorPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func showError(text: String) {
        label.text = text
    }
}

// MARK: Button Targets
extension ErrorViewController {
    
    @objc private func closeButtonDidPress() {
        presenter?.closeErrorView()
    }
}

// MARK: Setup UI Methods
private extension ErrorViewController {
    
    func setupUI() {
        title = NSLocalizedString("Error.Critical Error", comment: "")
        
        setupLabel()
        setupCloseButton()
    }
    
    func setupLabel() {
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textAlignment = .center
        label.textColor = .appWhite
        
        let layoutMargins = view.layoutMarginsGuide
        label.widthAnchor.constraint(equalTo: layoutMargins.widthAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: layoutMargins.centerXAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        label.centerYAnchor.constraint(equalTo: layoutMargins.centerYAnchor).isActive = true
    }
    
    func setupCloseButton() {
        view.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle(NSLocalizedString("Error.Close", comment: ""), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonDidPress), for: .touchDown)
        
        let layoutMargins = view.layoutMarginsGuide
        closeButton.widthAnchor.constraint(equalTo: layoutMargins.widthAnchor).isActive = true
        closeButton.centerXAnchor.constraint(equalTo: layoutMargins.centerXAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor).isActive = true
    }
}
