//
//  Coordiantor.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
