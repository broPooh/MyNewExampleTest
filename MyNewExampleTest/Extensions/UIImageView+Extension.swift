//
//  UIImageView+Extension.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import UIKit

import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(
            with: URL(string: imageUrl),
            placeholder: UIImage(systemName: "star")
        )
    }
}
