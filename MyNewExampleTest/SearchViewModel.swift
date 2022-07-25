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
    
    struct Input {
        //검색결과를 받아오는 text
    }
    
    struct Output {
        //검색결과가 nil인지 체크해서 lable 활성화
        //검색결과에 따른 화면 갱신
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
}
