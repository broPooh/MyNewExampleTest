//
//  Reusable.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String {
        get
    }
}

protocol ViewRepresentable {
    func setupView()
    func setupConstraints()
}
