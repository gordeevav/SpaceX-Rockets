//
//  ErrorViewController.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 31.08.2022.
//

import UIKit

// MARK: ErrorViewController
final class ErrorViewController: UIViewController, ErrorViewProtocol {
    
    var presenter: ErrorPresenterProtocol?
    
    private lazy var label = UILabel() .. {
        view.addSubview($0)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 5
        $0.textAlignment = .center
        $0.textColor = .appWhite
        
        let layoutMargins = view.layoutMarginsGuide
        $0.widthAnchor.constraint(equalTo: layoutMargins.widthAnchor).isActive = true
        $0.centerXAnchor.constraint(equalTo: layoutMargins.centerXAnchor).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
        $0.centerYAnchor.constraint(equalTo: layoutMargins.centerYAnchor).isActive = true
    }
    
    private lazy var closeButton = UIButton() .. {
        view.addSubview($0)
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(NSLocalizedString("Error.Close", comment: ""), for: .normal)
        $0.addTarget(self, action: #selector(closeButtonDidPress), for: .touchDown)
        
        let layoutMargins = view.layoutMarginsGuide
        $0.widthAnchor.constraint(equalTo: layoutMargins.widthAnchor).isActive = true
        $0.centerXAnchor.constraint(equalTo: layoutMargins.centerXAnchor).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Error.Critical Error", comment: "")
    }

    public func showError(text: String) {
        label.text = text
    }
    
    @objc
    private func closeButtonDidPress() {
        presenter?.closeErrorView()
    }
}
