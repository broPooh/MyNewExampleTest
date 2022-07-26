//
//  SearchViewController.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

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
        
        
        
        let customBarButton = createCustomBarButton()
        customBarButton.addTarget(self, action: #selector(favoriteButtonDidTap), for: .touchUpInside)
        let favoriteButton = UIBarButtonItem(customView: customBarButton)
        self.navigationItem.rightBarButtonItem = favoriteButton
    }
    
    private func createCustomBarButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = .yellow
        button.setTitle("즐겨찾기", for: .normal)
        //button.titleLabel?.textColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 75, height: 30)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
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
            .do(onNext: { text in
                if text != "" {
                    self.viewModel.isLoading.accept(true)
                    self.viewModel.searchMovie(query: text, start: 1)
                }
            })
            .do(onNext: { _ in
                self.viewModel.isLoading.accept(false)
            })
            .drive(onNext: { text in
                self.searchView.searchTableView.reloadData()
            })
            .disposed(by: disposeBag)
                
        input.searchBarReturn
                .bind {
                    self.viewModel.searchMovie(query: self.searchView.searchBar.text!, start: 1)
                }.disposed(by: disposeBag)
        
        output.movieResult
                .asDriver()
                .drive(onNext: { movieResult in
                    print(movieResult)
                    self.searchView.searchTableView.reloadData()
                })
                .disposed(by: disposeBag)
        
        output.isLoading
            .drive(onNext: { bool in
                bool ? self.searchView.showProgress() : self.searchView.dissmissProgress()
            })
            .disposed(by: disposeBag)
    }
    
    
    @objc func favoriteButtonDidTap() {
        print(#function)
        delegate?.favoriteButtonDidTap()
    }
    
}

// MARK: - TableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieResult.value.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = viewModel.movieResult.value.items?[indexPath.row] ?? Movie(subtitle: "", image: "", title: "", actor: "", userRating: "", pubDate: "", director: "", link: "")
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
