//
//  BuffModel.swift
//  BuffSDK
//
//  Created by Criss on 3/20/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import Foundation

struct BuffModel: Decodable {
    struct Question: Decodable {
        let title: String?
    }
    
    struct Answer: Decodable {
        let title: String?
    }
    
    struct Result: Decodable {
        let id: Int?
        let time_to_show: Int?
        let question: Question?
        let answers: [Answer]
    }
    
    let result: Result?
}
