//
//  FavoriteViewModel.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import Foundation

import RxCocoa
import RxSwift
import Action

final class FavoriteViewModel: CommonViewModel, ViewModelType {
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
        let favoriteButtonResult: Observable<Void>
    
    }
    
    func transform(input: Input) -> Output {
        let favoriteButton = input.favoriteButtonTap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)

        return Output(favoriteButtonResult: favoriteButton)
    }
        
    func deleteMovie(movie: MovieItem) -> Observable<[MovieItem]> {
        return Observable.just(())
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMap { _ in
                return Observable.just(movie)
            }.flatMap { movie in
                self.databaesManager.delete(movie: movie)
            }.flatMap { _ -> Observable<[MovieItem]> in
                self.databaesManager.movieList()
            }
        
//        return databaesManager.delete(movie: movie)
//            .flatMap { _ -> Observable<[MovieItem]> in
//                self.databaesManager.movieList()
//            }
    }
    
}
