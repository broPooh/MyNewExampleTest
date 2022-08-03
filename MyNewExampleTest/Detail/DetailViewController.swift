//
//  DetailViewController.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import UIKit
import WebKit

import RxSwift
import RxCocoa

class DetailViewController: BaseViewController {
    
    private var detailView: DetailView
    private var viewModel: DetailViewModel
    
    var disposeBag = DisposeBag()
    
    init(view: DetailView, viewModel: DetailViewModel) {
        self.detailView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationConfig()
        bindMovieData()
        bindWeb()
    }
    
    private func navigationConfig() {
        // 타이틀 지정
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.text = viewModel.movie.title ?? ""
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func bindMovieData() {
        
        
        let movieInfoView = detailView.movieInfoView

        movieInfoView.posterImageView.setImage(imageUrl: viewModel.movie.image ?? "")
        movieInfoView.titleLable.text = viewModel.movie.title?.htmlEscaped
        movieInfoView.directorLable.text = "감독: \(viewModel.movie.director ?? "")"
        movieInfoView.castLable.text = "출연: \(viewModel.movie.actor ?? "")"
        movieInfoView.rateLable.text = "평점: \(viewModel.movie.userRating ?? "")"
        
        changeButtonImage(favorite: viewModel.movie.favorite!)
    }
    
    func changeButtonImage(favorite: Bool) {
        let color: UIColor = favorite ? .yellow : .lightGray
        detailView.movieInfoView.favoriteButton.tintColor = color
    }
    
    func bindWeb() {
        guard let url = URL(string: viewModel.movie.link ?? "") else { print("Invalid URL"); return }
        print(url)
        let request = URLRequest(url: url)
        detailView.webView.load(request)
    }

}
