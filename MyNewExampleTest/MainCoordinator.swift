//
//  MainCoordinator.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import UIKit

protocol MainCoordinatorDelegate {
    func favoriteDidTap(_ coordinator: MainCoordinator)
}

class MainCoordinator: Coordinator, SearchViewControllerDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    var delegate: MainCoordinatorDelegate?


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SearchViewController()
        self.navigationController.viewControllers = [viewController]
    }
    
    func favoriteButtonDidTap() {
        delegate?.favoriteDidTap(self)
    }
    
}
