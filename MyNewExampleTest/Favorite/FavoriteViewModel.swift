//
//  FavoriteViewModel.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import Foundation

import RxCocoa
import RxSwift

final class FavoriteViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    var movieList: BehaviorRelay<[MovieItem]> {
        return RealmManager.shared.movieList()
    }
    
    struct Input {
        //즐겨찾기버튼 tap
        let favoriteButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        //즐겨찾기 영화리스트(DB)
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
    
    func deleteMovie(movie: MovieItem) {

        let favorite = RealmManager.shared.checkFavorite(title: movie.title, director: movie.director)
        
        if favorite {
            RealmManager.shared.delete(movie: movie)
        }
        
    }
    
    func deleteMovieTest(movie: MovieItem) -> Observable<[MovieItem]> {
        return RealmManager.shared.delete(movie: movie)
            .flatMap { _ -> Observable<[MovieItem]> in
                RealmManager.shared.movieList()
            }
    }
    
}
