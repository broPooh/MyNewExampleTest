//
//  CommonViewModel.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/08/04.
//

import Foundation

class CommonViewModel: NSObject {
    
    let databaesManager: DataBaseManagerType
    
    init(databaesManager: DataBaseManagerType) {
        self.databaesManager = databaesManager
    }
    
}
