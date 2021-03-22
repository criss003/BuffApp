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
    func modelUpdateDidSucced()
    func modelUpdateDidFail(error: BuffError)
}

class BuffViewModel {
        
    // MARK: Vars
    
    weak var delegate: BuffViewModelDelegate?
    
    // MARK: Methods
        
    func performModelUpdate() {
        BuffService().fetchBuffs(id: 1) { buffError in
            self.delegate?.modelUpdateDidFail(error: buffError)
        } successHandler: { buffData in
            print(buffData)
            self.delegate?.modelUpdateDidSucced()
        }

    }
}
