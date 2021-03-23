//
//  RowTypeModel.swift
//  BuffSDK
//
//  Created by Criss on 3/20/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import Foundation

struct RowTypeModelConstants {
    static let topSections = 2
}

enum RowTypeModel: Int, CaseIterable {
    case sender
    case question
    case answer
    
    func value(buffModel: BuffModel?, index: Int = 0) -> String? {
        guard let buffResult = buffModel else {
            return nil
        }

        switch self {
        case .sender:
            return buffResult.authorName
        case .question:
            return buffResult.question
        case .answer:
            return buffResult.answers[safe: index - RowTypeModelConstants.topSections]
        }
    }
    
    func avatar(buffModel: BuffModel?) -> String? {
        guard let buffResult = buffModel else {
            return nil
        }
        
        switch self {
        case .sender:
            return buffResult.avatarImageName
        case .question, .answer:
            return nil
        }
    }
}
