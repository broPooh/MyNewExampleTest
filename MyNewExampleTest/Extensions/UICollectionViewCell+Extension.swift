//
//  UICollectionViewCell+Extension.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import UIKit

extension UICollectionViewCell: Reusable {
   static var reuseIdentifier: String {
        return String(describing: self)
    }
}
