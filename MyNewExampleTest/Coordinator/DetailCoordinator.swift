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
    var movie: Movie
    

    init(navigationController: UINavigationController, movie: Movie) {
        self.navigationController = navigationController
        self.movie = movie
    }
    
    func start() {
        print("왜 안되니")
        let detailView = DetailView()
        let detailViewModel = DetailViewModel(movie: movie)
        let viewController = DetailViewController(view: detailView, viewModel: detailViewModel)
        
        print(navigationController)
        navigationController.navigationItem.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: true)
    }


    
}
