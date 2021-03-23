//
//  QuestionTableViewCell.swift
//  BuffSDK
//
//  Created by Criss on 3/22/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var circularTimer: CircularTimer!
    
    func configure(questionsInfoModel: QuestionsInfoModel) {
        valueLabel.text = questionsInfoModel.value
        circularTimer.startTimer(TimeInterval(questionsInfoModel.countdown))
    }
    
    func stopCountdown() {
        circularTimer.stopTimer()
    }
}
