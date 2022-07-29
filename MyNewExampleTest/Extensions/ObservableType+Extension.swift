//
//  ObservableType+Extension.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/27.
//

import Foundation

import RxCocoa
import RxSwift

extension ObservableType {
    
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
