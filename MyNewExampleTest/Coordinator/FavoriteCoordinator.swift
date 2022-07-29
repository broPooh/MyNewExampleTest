//
//  FavoriteCoordinator.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import UIKit

protocol FavoriteCoordinatorDelegate {
    func favoriteCellDidTap(_ coordinator: FavoriteCoordinator)
}

class FavoriteCoordinator: Coordinator, FavoriteViewControllerDelegate {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    var delegate: FavoriteCoordinatorDelegate?
    

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.viewControllers = []
    }
    
    func start() {
        let favoriteView = FavoriteView()
        let favoriteViewModel = FavoriteViewModel()
        let viewController = FavoriteViewController(view: favoriteView, viewModel: favoriteViewModel)
        navigationController.present(viewController, animated: true, completion: nil)
    }
    
    func favoriteCellDidTap() {
        delegate?.favoriteCellDidTap(self)
    }
    
}
