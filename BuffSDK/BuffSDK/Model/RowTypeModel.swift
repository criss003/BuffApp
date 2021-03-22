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

enum RowTypeModel: Int {
    case sender
    case question
    case answer
    
    func value(buffModel: BuffModel?, index: Int = 0) -> String? {
        guard let buffResult = buffModel?.result else {
            return nil
        }

        switch self {
        case .sender:
            let name = [buffResult.author?.first_name, buffResult.author?.last_name].compactMap {
                $0?.isEmpty == false ? $0 : nil
            }.joined(separator: " ")
            return name
        case .question:
            return buffResult.question?.title
        case .answer:
            return buffResult.answers[safe: index - RowTypeModelConstants.topSections]?.title
        }
    }
    
    func avatar(buffModel: BuffModel?) -> String? {
        guard let buffResult = buffModel?.result else {
            return nil
        }
        
        switch self {
        case .sender:
            return buffResult.author?.image
        case .question, .answer:
            return nil
        }
    }
}
