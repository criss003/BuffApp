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
    
    func configure(rowInfo: (value: String?, avatar: String?)) {
        valueLabel.text = rowInfo.value
        circularTimer.startTimer(3)
    }
    
    func stopCountdown() {
        circularTimer.stopTimer()
    }
}
