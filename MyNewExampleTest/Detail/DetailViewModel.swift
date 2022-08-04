//
//  DetailViewModel.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import Foundation

import RxCocoa
import RxSwift

final class DetailViewModel: ViewModelType {
    typealias Favorite = Bool
    
    var disposeBag = DisposeBag()
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    struct Input {
        let favoriteButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let isFavorite: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let isFavorite = input.favoriteButtonTap
            .flatMap { () -> Observable<Bool> in
                return Observable.just(RealmManager.shared.checkFavorite(title: self.movie.title?.htmlEscaped ?? "", director: self.movie.director?.htmlEscaped ?? ""))
            }.asDriver(onErrorJustReturn: false)
        
        return Output(isFavorite: isFavorite)
    }
    
    func checkFavoriteMovie(favorite: Bool) -> Bool{
        _ = favorite ? RealmManager.shared.delete(movie: movie) : RealmManager.shared.createMovie(movie: movie)
        return !favorite
    }
    
}
