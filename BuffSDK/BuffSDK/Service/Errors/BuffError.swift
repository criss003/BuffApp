//
//  BuffError.swift
//  BuffSDK
//
//  Created by Criss on 3/22/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import Foundation

struct BuffErrorConstants {
    static let invalidDataErrorTitle = "Invalid Data Title"
    static let invalidDataErrorMessage = "Invalid Data Message"
    static let failedErrorTitle = "Request Failed Title"
    static let failedErrorMessage = "Request Failed Message"
}

class BuffError: Error {
    enum ErrorType: Error {
        case failed
        case invalidData
        
        var title: String {
            switch self {
            case .failed:
                return BuffErrorConstants.failedErrorTitle
            case .invalidData:
                return BuffErrorConstants.invalidDataErrorTitle
            }
        }
        
        var message: String {
            switch self {
            case .failed:
                return BuffErrorConstants.failedErrorMessage
            case .invalidData:
                return BuffErrorConstants.invalidDataErrorMessage
            }
        }
    }
    
    private var errorType: ErrorType = .failed
    private var errorMessage: String?
    
    init(errorType: ErrorType) {
        self.errorType = errorType
    }
    
    init(error: Error?) {
        self.errorMessage = error?.localizedDescription
    }
    
    var message: String {
        return errorMessage ?? errorType.message
    }
    
    var title: String? {
        return errorType.title
    }
}
