//
//  SearchTableViewCell.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import UIKit

import SnapKit

final class SearchTableViewCell: UITableViewCell, ViewRepresentable {
    
    var favoriteButtonAction: ( () -> () )?
    var movie: Movie!
    
    let posterImageView: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.backgroundColor = .yellow
        posterImageView.clipsToBounds = true
        return posterImageView
    }()
    
    let titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.font = .boldSystemFont(ofSize: 20)
        titleLable.numberOfLines = 1
        return titleLable
    }()
    
    let directorLable: UILabel = {
        let directorLable = UILabel()
        directorLable.numberOfLines = 1
        return directorLable
    }()
    
    let castLable: UILabel = {
        let castLable = UILabel()
        castLable.numberOfLines = 1
        return castLable
    }()
    
    let rateLable: UILabel = {
        let rateLable = UILabel()
        return rateLable
    }()
    
    let favoriteButton: UIButton = {
        let favoriteButton = UIButton()
        favoriteButton.setImage(UIImage(systemName: SystemImage.starFill.rawValue), for: .normal)
        favoriteButton.tintColor = .lightGray
        return favoriteButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        buttonConfig()
        self.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLable)
        contentView.addSubview(directorLable)
        contentView.addSubview(castLable)
        contentView.addSubview(rateLable)
        contentView.addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.82)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-8)
            make.height.equalTo(30)
        }
        
        directorLable.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(4)
            make.leading.equalTo(titleLable.snp.leading)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        castLable.snp.makeConstraints { make in
            make.top.equalTo(directorLable.snp.bottom).offset(4)
            make.leading.equalTo(titleLable.snp.leading)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        rateLable.snp.makeConstraints { make in
            make.top.equalTo(castLable.snp.bottom).offset(4)
            make.leading.equalTo(titleLable.snp.leading)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteButton.setImage(nil, for: .normal)
        let favorite = RealmManager.shared.checkFavorite(title: movie.title!, director: movie.director!)
        changeButtonImage(favorite: favorite)
    }
    
    func configureData() {
        posterImageView.setImage(imageUrl: movie.image ?? "ss")
        titleLable.text = movie.title?.htmlEscaped
        directorLable.text = "감독: \(movie.director ?? "")"
        castLable.text = "출연: \(movie.actor ?? "")"
        rateLable.text = "평점: \(movie.userRating ?? "")"
        movie.favorite = RealmManager.shared.checkFavorite(title: movie.title?.htmlEscaped ?? "", director: movie.director ?? "")
        //let favorite = RealmManager.shared.checkFavorite(title: movie.title!, pubDate: movie.pubDate!)
        
        changeButtonImage(favorite: movie.favorite!)
    }
    
    func buttonConfig() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
    }
    
    func changeButtonImage(favorite: Bool) {
        let color: UIColor = favorite ? .yellow : .lightGray
        favoriteButton.setImage(UIImage(systemName: SystemImage.starFill.rawValue), for: .normal)
        favoriteButton.tintColor = color
    }
    
    @objc func favoriteButtonClicked() {
        favoriteButtonAction?()
    }
    
}
