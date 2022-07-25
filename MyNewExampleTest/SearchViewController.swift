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

class SearchViewController: BaseViewController {
    var delegate: SearchViewControllerDelegate?
    
    private var searchView: SearchView
    private var viewModel: SearchViewModel
    
    init(view: SearchView, viewModel: SearchViewModel) {
        self.searchView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                        
    }
        
    override func configure() {
        super.configure()
        
        navigationConfig()
    }
    
    private func navigationConfig() {
        navigationItem.title = "네이버 영화 검색"
        let favoriteBarButton = UIBarButtonItem(title: "즐겨찾기", style: .plain, target: self, action: #selector(favoriteButtonDidTap))
        self.navigationItem.rightBarButtonItem = favoriteBarButton
    }
    
    private func searchBarConfig() {
        
    }
    
    private func tableViewConfig() {
        
    }
    
    private func bindInput() {
        
    }
    
    private func bindOutput() {
        
    }
        
    @objc func favoriteButtonDidTap() {
        delegate?.favoriteButtonDidTap()
   }
    
}
