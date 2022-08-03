//
//  FavoriteViewController.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol FavoriteViewControllerDelegate {
    func favoriteCellDidTap()
}

class FavoriteViewController: BaseViewController {
    var delegate: FavoriteViewControllerDelegate?
    
    private var favoriteView: FavoriteView
    private var viewModel: FavoriteViewModel
    
    var disposeBag = DisposeBag()
    
    init(view: FavoriteView, viewModel: FavoriteViewModel) {
        self.favoriteView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = favoriteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
        titleLabel.text = "즐겨찾기 목록"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.navigationItem.titleView = titleLabel
        
        let dissmissBarButton = UIBarButtonItem(image: UIImage(systemName: SystemImage.xmark.rawValue), style: .plain, target: self, action: #selector(dissmissButtonDidTap))
        
        self.navigationItem.leftBarButtonItem = dissmissBarButton
    }
    
    private func tableViewConfig() {
        favoriteView.favoriteTableView.delegate = self
        favoriteView.favoriteTableView.dataSource = self
    }
    
    @objc func dissmissButtonDidTap() {
        print(#function)
        dismiss(animated: true)
    }
    

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var movie = Movie(subtitle: "", image: "", title: "", actor: "", userRating: "", pubDate: "", director: "", link: "")
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as! FavoriteTableViewCell
        
        cell.favoriteButtonAction = {
            movie.favorite?.toggle()
            cell.changeButtonImage(favorite: movie.favorite!)
        }
        
        cell.configureData(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

