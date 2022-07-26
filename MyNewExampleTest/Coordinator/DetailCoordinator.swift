//
//  DetailCoordinator.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import UIKit

class DetailCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
  
    

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.viewControllers = []
    }
    
    func start() {
        let detailView = DetailView()
        let detailViewModel = DetailViewModel()
        let viewController = DetailViewController()
        navigationController.pushViewController(viewController, animated: true)
    }

    
}
