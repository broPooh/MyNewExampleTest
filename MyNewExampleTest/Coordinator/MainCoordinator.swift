//
//  MainCoordinator.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import UIKit

protocol MainCoordinatorDelegate {
    func favoriteDidTap(_ coordinator: MainCoordinator)
    func searchCellDidTap(_ coordinator: MainCoordinator)
}

class MainCoordinator: Coordinator, SearchViewControllerDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    var delegate: MainCoordinatorDelegate?


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchView = SearchView()
        let searchViewModel = SearchViewModel()

        let viewController = SearchViewController(view: searchView, viewModel: searchViewModel)
        viewController.delegate = self
        
        self.navigationController.viewControllers = [viewController]
    }
    
    func favoriteButtonDidTap() {
        delegate?.favoriteDidTap(self)
    }
    
    func searchCellDidTap() {
        delegate?.searchCellDidTap(self)
    }
    
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}
