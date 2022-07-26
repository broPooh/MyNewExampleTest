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
    
    struct Input {
        //즐겨찾기버튼 tap
        //cell did tap?
    }
    
    struct Output {
        //즐겨찾기 영화리스트(DB)
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
}
