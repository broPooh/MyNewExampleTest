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
    
    var movieResult: BehaviorRelay<MovieResult> = BehaviorRelay(value: MovieResult(lastBuildDate: "", start: 1, total: 1, items: [
        Movie(subtitle: "test", image: "https://search.pstatic.net/common?type=o&size=174x246&quality=100&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2", title: "title", actor: "actor", userRating: "5.0", pubDate: "2020.20.20", director: "director", link: "link"),
        Movie(subtitle: "test", image: "https://search.pstatic.net/common?type=o&size=174x246&quality=100&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2", title: "title", actor: "actor", userRating: "5.0", pubDate: "2020.20.20", director: "director", link: "link"),
        Movie(subtitle: "test", image: "https://search.pstatic.net/common?type=o&size=174x246&quality=100&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2", title: "title", actor: "actor", userRating: "5.0", pubDate: "2020.20.20", director: "director", link: "link"),
        Movie(subtitle: "test", image: "https://search.pstatic.net/common?type=o&size=174x246&quality=100&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2", title: "title", actor: "actor", userRating: "5.0", pubDate: "2020.20.20", director: "director", link: "link"),
        Movie(subtitle: "test", image: "https://search.pstatic.net/common?type=o&size=174x246&quality=100&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2", title: "title", actor: "actor", userRating: "5.0", pubDate: "2020.20.20", director: "director", link: "link"),
        Movie(subtitle: "test", image: "https://search.pstatic.net/common?type=o&size=174x246&quality=100&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2", title: "title", actor: "actor", userRating: "5.0", pubDate: "2020.20.20", director: "director", link: "link"),
    ], display: 1))

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
    
}
