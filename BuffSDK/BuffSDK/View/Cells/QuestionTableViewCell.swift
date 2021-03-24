//
//  QuestionTableViewCell.swift
//  BuffSDK
//
//  Created by Criss on 3/22/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var circularTimer: CircularTimer!
    
    func configure(questionsInfoModel: QuestionsInfoModel, delegate: CircularTimerDelegate?) {
        valueLabel.text = questionsInfoModel.value
        circularTimer.delegate = delegate
        circularTimer.startTimer(TimeInterval(questionsInfoModel.countdown))
    }
    
    func stopCountdown() {
        circularTimer.stopTimer()
    }
}
