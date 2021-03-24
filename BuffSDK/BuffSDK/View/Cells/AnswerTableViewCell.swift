//
//  AnswerTableViewCell.swift
//  BuffSDK
//
//  Created by Criss on 3/22/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import UIKit

struct AnswerTableViewCellConstants {
    static let correctImage = "correct"
    static let genericImage = "genericAnswer"
}

class AnswerTableViewCell: UITableViewCell {
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    
    func configure(questionsInfoModel: QuestionsInfoModel) {
        valueLabel.text = questionsInfoModel.value
    }
    
    func selectAnswer() {
        backgroundImageView.backgroundColor = .cyan
        iconImage.image = UIImage(named: AnswerTableViewCellConstants.correctImage,
                                  in: Bundle.sdkBundle,
                                  compatibleWith: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.backgroundColor = .white
        iconImage.image = UIImage(named: AnswerTableViewCellConstants.genericImage,
                                  in: Bundle.sdkBundle,
                                  compatibleWith: nil)
    }
}
