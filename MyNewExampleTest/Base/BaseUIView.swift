//
//  BaseUIView.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import UIKit

class BaseUIView: UIView, ViewRepresentable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    func setupView() { }

    func setupConstraints() { }
}
