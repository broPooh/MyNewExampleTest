//
//  FavoriteTableViewCell.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/08/03.
//

import UIKit

import SnapKit

final class FavoriteTableViewCell: UITableViewCell, ViewRepresentable {

    var favoriteButtonAction: ( () -> () )?
    
    var movieInfoView = MovieInfoView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        buttonConfig()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(movieInfoView)
    }
    
    func setupConstraints() {
        movieInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureData(movie: Movie) {
        movieInfoView.posterImageView.setImage(imageUrl: movie.image ?? "ss")
        movieInfoView.titleLable.text = movie.title?.htmlEscaped
        movieInfoView.directorLable.text = "감독: \(movie.director ?? "")"
        movieInfoView.castLable.text = "출연: \(movie.actor ?? "")"
        movieInfoView.rateLable.text = "평점: \(movie.userRating ?? "")"
        
        changeButtonImage(favorite: movie.favorite!)
    }
    
    func buttonConfig() {
        movieInfoView.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
    }
    
    func changeButtonImage(favorite: Bool) {
        let color: UIColor = favorite ? .yellow : .lightGray
        movieInfoView.favoriteButton.tintColor = color
    }
    
    @objc func favoriteButtonClicked() {
        favoriteButtonAction?()
    }
    
}
