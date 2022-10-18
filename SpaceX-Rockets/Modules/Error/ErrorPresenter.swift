//
//  ErrorPresenter.swift
//  SpaceX-Rockets
//
//  Created by Александр on 31.08.2022.
//

import Foundation

// MARK: ErrorPresenter
final class ErrorPresenter: ErrorPresenterProtocol {
    
    private let router: RouterProtocol
    private let view: ErrorViewProtocol
      
    init(view: ErrorViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func closeErrorView() {
        exit(0)
    }
    
    func showError(error: Error) {
        let text = error.localizedDescription
        view.showError(text: text)
    }
}
