//
//  AppCoordinator.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import UIKit

class AppCoordinator: Coordinator, MainCoordinatorDelegate {
    
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainViewController()
    }
    
    private func showMainViewController() {
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    private func showFavoriteViewController() {
        
    }
    
    func favoriteDidTap(_ coordinator: MainCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showFavoriteViewController()
    }
    
    
}
