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
    let movieList: BehaviorRelay<[Movie]> = BehaviorRelay(value: [
        Movie(subtitle: "test", image: "https://search.pstatic.net/common?type=o&size=174x246&quality=100&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2", title: "title", actor: "actor", userRating: "5.0", pubDate: "2020.20.20", director: "director", link: "link"),
        Movie(subtitle: "test", image: "https://search.pstatic.net/common?type=o&size=174x246&quality=100&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2", title: "title", actor: "actor", userRating: "5.0", pubDate: "2020.20.20", director: "director", link: "link"),
        Movie(subtitle: "test", image: "https://search.pstatic.net/common?type=o&size=174x246&quality=100&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2", title: "title", actor: "actor", userRating: "5.0", pubDate: "2020.20.20", director: "director", link: "link"),
        Movie(subtitle: "test", image: "https://search.pstatic.net/common?type=o&size=174x246&quality=100&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2", title: "title", actor: "actor", userRating: "5.0", pubDate: "2020.20.20", director: "director", link: "link"),
        Movie(subtitle: "test", image: "https://search.pstatic.net/common?type=o&size=174x246&quality=100&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2", title: "title", actor: "actor", userRating: "5.0", pubDate: "2020.20.20", director: "director", link: "link"),
        Movie(subtitle: "test", image: "https://search.pstatic.net/common?type=o&size=174x246&quality=100&direct=true&src=https%3A%2F%2Fs.pstatic.net%2Fmovie.phinf%2F20220708_75%2F16572722362230AyHS_JPEG%2Fmovie_image.jpg%3Ftype%3Dw640_2", title: "title", actor: "actor", userRating: "5.0", pubDate: "2020.20.20", director: "director", link: "link"),
    ])
    
    private let isLoading = BehaviorRelay<Bool>(value: false)
    
    struct Input {
        //검색결과를 받아오는 text
        let searchText: ControlProperty<String>
        //서치바 검색버튼 탭
        let searchBarReturn: ControlEvent<Void>
    }
    
    struct Output {
        //검색결과가 nil인지 체크해서 lable 활성화
        //검색결과에 따른 화면 갱신
        //let fetchData: BehaviorSubject<String>
        //var movieListObservable: BehaviorRelay<MovieResult>
        let searchInputText: Driver<String>
        let searchInputReturn: Driver<String>
        let isLoading: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        input.searchText
            .bind(to: searchInputText)
            .disposed(by: disposeBag)
        
        return Output(searchInputText: searchInputText.asDriver(onErrorJustReturn: ""),
                      searchInputReturn: searchInputReturn.asDriver(onErrorJustReturn: ""),
                      isLoading: isLoading.asDriver())
        
    }
    
}
