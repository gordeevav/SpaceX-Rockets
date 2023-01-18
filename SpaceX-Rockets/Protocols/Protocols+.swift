//
//  Protocols+.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 13.01.2023.
//

import UIKit

extension LoadingViewProtocol {
    func setupLoadingViews(controllerView: UIView, mainView: UIView?) {
        controllerView.addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.sizeToFit()
        activityIndicatorView.color = .appWhite
    
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: controllerView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: controllerView.centerYAnchor),
            activityIndicatorView.widthAnchor.constraint(
                equalToConstant: activityIndicatorView.frame.width
            ),
            activityIndicatorView.heightAnchor.constraint(
                equalToConstant: activityIndicatorView.frame.height
            )
        ])
                
        self.mainView = mainView
    }
    
    func showLoading() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        
        mainView?.isHidden = true
    }
    
    func hideLoading() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        
        mainView?.isHidden = false
    }
}
