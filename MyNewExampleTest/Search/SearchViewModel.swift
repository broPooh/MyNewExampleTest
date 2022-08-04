//
//  SearchViewModel.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import Foundation

import RxCocoa
import RxSwift

final class SearchViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    let searchInputText: BehaviorRelay<String> = BehaviorRelay(value: "")
    let searchInputReturn: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    let startPage: BehaviorRelay<Int> = BehaviorRelay(value: 1)
    let totalCount: BehaviorRelay<Int> = BehaviorRelay(value: 1)
    
    var movieResult: BehaviorRelay<MovieResult> = BehaviorRelay(value: MovieResult(lastBuildDate: "", start: 1, total: 1, items: [], display: 1))

    let isLoading = BehaviorRelay<Bool>(value: false)
    
    struct Input {
        //검색결과를 받아오는 text
        let searchText: ControlProperty<String>
        //서치바 검색버튼 탭
        let searchBarReturn: ControlEvent<Void>
    }
    
    struct Output {
        //검색결과에 따른 화면 갱신
        //let searchInputText: Driver<String>
        let searchInputText: Driver<MovieResult>
        let searchInputReturn: Driver<MovieResult>
        let isLoading: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        input.searchText
            .bind(to: searchInputText)
            .disposed(by: disposeBag)
        
        let searchText = searchInputText
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .filter({ text in
                return text != ""
            })
            .do(onNext: { _ in
                self.isLoading.accept(true)
            })
            .flatMap { text  in APIManager.shared.searchMovie(query: text, start: 1)
            }
            .do(onNext: { _ in
                self.isLoading.accept(false)
            })
            .asDriver(onErrorJustReturn: MovieResult(lastBuildDate: nil, start: 1, total: 1, items: [], display: 10))
            .asDriver()
        
        
        let searchButton = input.searchBarReturn
            .map({ () -> String in
                return self.searchInputText.value
            })
            .do(onNext: { _ in
                self.isLoading.accept(true)
            })
            .flatMap { text in APIManager.shared.searchMovie(query: text, start: 1) }
            .do(onNext: { _ in
                self.isLoading.accept(false)
            })
            .asDriver(onErrorJustReturn: MovieResult(lastBuildDate: nil, start: 1, total: 1, items: [], display: 10))

            
        
        return Output(searchInputText: searchText,
                      searchInputReturn: searchButton,
                      isLoading: isLoading.asDriver())
        
    }
    
    func searchMovie(query: String, start: Int) {
        APIManager.shared.searchMovie(query: query, start: start)
            .bind(to: movieResult)
            .disposed(by: disposeBag)
    }
    
    func fetchMovie(start: Int) -> Observable<Void> {
        return searchInputText
            .filter({ text in
                return text != ""
            })
            .do(onNext: { _ in
                self.isLoading.accept(true)
            })
            .flatMap { text  in APIManager.shared.searchMovie(query: text, start: start)
            }
            .do(onNext: { movieResult in
                self.isLoading.accept(false)
                
                let addArray = movieResult.items
                let oldArray = self.movieResult.value.items
                let newArray = oldArray + addArray
                
                var newMovieResult = movieResult
                newMovieResult.items = newArray
                
                self.movieResult.accept(newMovieResult)
                self.startPage.accept(movieResult.start ?? 1)
                self.totalCount.accept(movieResult.total ?? 1)
            })
            .map { _ in}
            
    }
    
    func checkFavoriteMovie(movie: Movie) -> Bool {
       let favorite = RealmManager.shared.checkFavorite(title: movie.title ?? "", pubDate: movie.pubDate ?? "")
        
        if favorite {
            RealmManager.shared.delete(movie: movie)
            return false
        } else {
            RealmManager.shared.createMovie(movie: movie)
            return true
        }
        
    }
    
}
