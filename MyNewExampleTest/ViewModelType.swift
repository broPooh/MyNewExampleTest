//
//  ViewModelType.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import Foundation
import RxSwift

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
