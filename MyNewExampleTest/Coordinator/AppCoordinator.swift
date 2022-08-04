//
//  AppCoordinator.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import UIKit

class AppCoordinator: Coordinator, MainCoordinatorDelegate, FavoriteCoordinatorDelegate {
       
        
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
        let coordinator = FavoriteCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
    }
    
    private func showDetailViewController(movie: Movie) {
        let coordinator = DetailCoordinator(navigationController: navigationController, movie: movie)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func favoriteDidTap(_ coordinator: MainCoordinator) {
        self.showFavoriteViewController()
    }
    
    func searchCellDidTap(_ coordinator: MainCoordinator, movie: Movie) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showDetailViewController(movie: movie)
    }
    
    func favoriteCellDidTap(_ coordinator: FavoriteCoordinator, movie: Movie) {
        print("눌렸니")
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        self.showDetailViewControllerFromFavorite(favorite: coordinator, movie: movie)
    }
    
    func showDetailViewControllerFromFavorite(favorite: FavoriteCoordinator, movie: Movie) {
        print("눌렸니 check")
        let coordinator = DetailCoordinator(navigationController: favorite.favoriteNavigation!, movie: movie)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
}
