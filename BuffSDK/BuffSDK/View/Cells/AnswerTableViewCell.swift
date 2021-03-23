//
//  AnswerTableViewCell.swift
//  BuffSDK
//
//  Created by Criss on 3/22/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    @IBOutlet weak var valueLabel: UILabel!
        
    func configure(questionsInfoModel: QuestionsInfoModel) {
        valueLabel.text = questionsInfoModel.value
    }
    
    func selectAnswer() {
        
    }
}
