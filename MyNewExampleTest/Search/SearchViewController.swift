//
//  SearchViewController.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import UIKit

import RxCocoa
import RxSwift

protocol SearchViewControllerDelegate {
    func favoriteButtonDidTap()
}

class SearchViewController: BaseViewController {
    var delegate: SearchViewControllerDelegate?
    
    private var searchView: SearchView
    private var viewModel: SearchViewModel
    
    var disposeBag = DisposeBag()
    
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
                        
        bindInput()
    }
        
    override func configure() {
        super.configure()
        
        navigationConfig()
        searchBarConfig()
        tableViewConfig()
    }
    
    private func navigationConfig() {
        //navigationItem.title = "네이버 영화 검색"
        
        // 타이틀 지정
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.text = "네이버 영화 검색"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        
        
        let favoriteBarButton = UIBarButtonItem(title: "즐겨찾기", style: .plain, target: self, action: #selector(favoriteButtonDidTap))
        self.navigationItem.rightBarButtonItem = favoriteBarButton
    }
    
    private func searchBarConfig() {
        searchView.searchBar.delegate = self
    }
    
    private func tableViewConfig() {
        searchView.searchTableView.delegate = self
        searchView.searchTableView.dataSource = self
    }
    
    private func bindInput() {
        let input = SearchViewModel.Input(searchText: searchView.searchBar.rx.text.orEmpty, searchBarReturn: searchView.searchBar.rx.searchButtonClicked)
        let output = viewModel.transform(input: input)
        
        output.searchInputText
            .debounce(.seconds(1))
            .drive(onNext: { text in
                print(text)
            })
            .disposed(by: disposeBag)
        
        output.isLoading
            .drive(onNext: { bool in
                bool ? self.searchView.showProgress() : self.searchView.dissmissProgress()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindOutput() {
        
    }
        
    @objc func favoriteButtonDidTap() {
        delegate?.favoriteButtonDidTap()
   }
    
}

// MARK: - TableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = viewModel.movieList.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as! SearchTableViewCell
        
        cell.favoriteButtonAction = {
            print("버튼 클릭")
        }
        
        cell.configureData(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

// MARK: - SearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
}
