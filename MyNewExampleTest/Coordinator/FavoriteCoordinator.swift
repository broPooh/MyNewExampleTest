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
    }
    
    func start() {
        let favoriteView = FavoriteView()
        let favoriteViewModel = FavoriteViewModel()
        let viewController = FavoriteViewController(view: favoriteView, viewModel: favoriteViewModel)
        
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .fullScreen
        //현재의 화면 뷰컨트롤러에서 화면전환을 요청해야함..!!
        navigationController.present(nav, animated: true, completion: nil)
    }
    
    func favoriteCellDidTap() {
        delegate?.favoriteCellDidTap(self)
    }
    
}
