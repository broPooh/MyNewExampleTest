//
//  DetailViewModel.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import Foundation

import RxCocoa
import RxSwift

final class DetailViewModel: CommonViewModel, ViewModelType {
    typealias Favorite = Bool
    
    var disposeBag = DisposeBag()
    
    var movie: Movie
    
    init(movie: Movie, databaseManager: DataBaseManagerType) {
        self.movie = movie
        super.init(databaesManager: databaseManager)
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
                return Observable.just(self.databaesManager.checkFavorite(title: self.movie.title?.htmlEscaped ?? "", director: self.movie.director?.htmlEscaped ?? ""))
            }.asDriver(onErrorJustReturn: false)
        
        return Output(isFavorite: isFavorite)
    }
    
    func checkFavoriteMovie(favorite: Bool) -> Bool{
        _ = favorite ? databaesManager.delete(movie: MovieItem.convertMovie(movie: movie)) : databaesManager.createMovie(movie: movie)
        return !favorite
    }
}
