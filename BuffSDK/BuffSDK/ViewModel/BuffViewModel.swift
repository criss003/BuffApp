//
//  BuffViewModel.swift
//  BuffSDK
//
//  Created by Criss on 3/20/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import Foundation

struct BuffViewModelConstants {
    static let errorTitle = "Error"
    static let errorMessage = "You have no internet connection."
}

protocol BuffViewModelDelegate: class {
    func modelUpdateDidFinish()
}

class BuffViewModel {
        
    // MARK: Vars
    
    weak var delegate: BuffViewModelDelegate?
    
    // MARK: Methods
        
    func performModelUpdate() {
        BuffService().fetchBuffs(completionHandler: { dataBuffs in
            print(dataBuffs)
            self.delegate?.modelUpdateDidFinish()
        })
    }
}
