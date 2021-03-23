//
//  BuffModel.swift
//  BuffSDK
//
//  Created by Criss on 3/20/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import Foundation

struct BuffModel {
    var authorName: String?
    var avatarImageName: String?
    var question: String?
    var answers: [String] = []
    var countdown: Int = 0
    
    init(buffDecodable: BuffDecodable) {
        guard let buffResult = buffDecodable.result else {
            return
        }
        authorName = [buffResult.author?.first_name, buffResult.author?.last_name].compactMap {
            $0?.isEmpty == false ? $0 : nil
        }.joined(separator: " ")
        avatarImageName = buffResult.author?.image
        question = buffResult.question?.title
        answers = buffResult.answers.compactMap {
            $0.title
        }
        countdown = buffResult.time_to_show ?? 0
    }
}
