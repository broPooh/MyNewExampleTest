//
//  TransitionModel.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/08/03.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
