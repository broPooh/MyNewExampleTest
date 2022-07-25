//
//  SearchViewController.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import UIKit


protocol SearchViewControllerDelegate {
    func favoriteButtonDidTap()
}

class SearchViewController: UIViewController {
    var delegate: SearchViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
                
    }
    
    private func configUI() {
        navigationConfig()
    }
    
    private func navigationConfig() {
        
        navigationItem.title = "네이버 영화 검색"
        
        let favoriteBarButton = UIBarButtonItem(title: "즐겨찾기", style: .plain, target: self, action: #selector(favoriteButtonDidTap))
        self.navigationItem.rightBarButtonItem = favoriteBarButton
    }
    
    @objc func favoriteButtonDidTap() {
        delegate?.favoriteButtonDidTap()
   }
    
}
