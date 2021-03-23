//
//  BuffDecodable.swift
//  BuffSDK
//
//  Created by Criss on 3/23/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import Foundation

struct BuffDecodable: Decodable {
    struct Question: Decodable {
        let title: String?
    }
    
    struct Answer: Decodable {
        let title: String?
    }
    
    struct Author: Decodable {
        let first_name: String?
        let last_name: String?
        let image: String?
    }
    
    struct Result: Decodable {
        let id: Int?
        let time_to_show: Int?
        let author: Author?
        let question: Question?
        let answers: [Answer]
    }
    
    let result: Result?
}
