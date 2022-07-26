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
    func searchCellDidTap(movie: Movie)
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
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //즐겨찾기 화면에서 복귀시 화면 갱신을 위함.
        //이거 말고 다른 방법이 맞는거 같은데..
        searchView.searchTableView.reloadData()
    }
    
    override func configure() {
        super.configure()
        
        navigationConfig()
        tableViewConfig()
    }
    
    private func navigationConfig() {
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
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 75, height: 30)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }
    
    
    private func tableViewConfig() {
        searchView.searchTableView.delegate = self
        searchView.searchTableView.dataSource = self
        searchView.searchTableView.prefetchDataSource = self
    }
    
    private func bind() {
        let input = SearchViewModel.Input(searchText: searchView.searchBar.rx.text.orEmpty, searchBarReturn: searchView.searchBar.rx.searchButtonClicked)
        
        let output = viewModel.transform(input: input)
        
        output.searchInputText
            .drive(onNext: { movieResult in
                self.viewModel.movieResult.accept(movieResult)
                self.viewModel.startPage.accept(movieResult.start ?? 1)
                self.viewModel.totalCount.accept(movieResult.total ?? 1)
                
                self.searchView.searchTableView.reloadData()
            })
            .disposed(by: disposeBag)
                    
                
        output.searchInputReturn
            .drive(onNext: { movieResult in
                self.viewModel.movieResult.accept(movieResult)
                self.viewModel.startPage.accept(movieResult.start ?? 1)
                self.viewModel.totalCount.accept(movieResult.total ?? 1)
                
                self.searchView.searchBar.resignFirstResponder()
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
        delegate?.favoriteButtonDidTap()
    }
    
}

// MARK: - TableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieResult.value.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var movie = viewModel.movieResult.value.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as! SearchTableViewCell
        
        cell.movie = movie
        
        cell.favoriteButtonAction = { [unowned self] in
                        
            let changeFavorite = self.viewModel.checkFavoriteMovie(movie: movie)
            movie.favorite = changeFavorite
            //let favorite = self.viewModel.checkFavoriteMovie(movie: movie)
            //movie.favorite = favorite
            
            cell.changeButtonImage(favorite: movie.favorite!)
        }
        cell.configureData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movieResult.value.items[indexPath.row]
        delegate?.searchCellDidTap(movie: movie)
    }
    
}

// MARK: - TableView Prefetcing
extension SearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let itemCount = viewModel.movieResult.value.items.count
        guard let totalCount = viewModel.movieResult.value.total else { return }
        
        for indexPath in indexPaths {
            if itemCount - 1 == indexPath.row && itemCount < totalCount {
                let start = viewModel.startPage.value + 1
                viewModel.fetchMovie(start: start)
                    .subscribe(onNext: {
                        self.searchView.searchTableView.reloadData()
                    })
                    .disposed(by: disposeBag)
            }
        }
    }
    
    
}
