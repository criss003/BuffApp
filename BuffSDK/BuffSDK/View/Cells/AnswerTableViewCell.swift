//
//  AnswerTableViewCell.swift
//  BuffSDK
//
//  Created by Criss on 3/22/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import UIKit

protocol AnswerTableViewCellDelegate: class {
    func didSelectAction()
}

class AnswerTableViewCell: UITableViewCell {
    @IBOutlet weak var valueLabel: UILabel!
    
    weak var delegate: AnswerTableViewCellDelegate?
    
    func configure(rowInfo: (value: String?, avatar: String?)) {
        valueLabel.text = rowInfo.value
    }
}
