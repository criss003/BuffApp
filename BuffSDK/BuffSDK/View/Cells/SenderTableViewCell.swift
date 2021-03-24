//
//  SenderTableViewCell.swift
//  BuffSDK
//
//  Created by Criss on 3/22/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import UIKit

protocol SenderTableViewCellDelegate: class {
    func didCloseAction()
}

class SenderTableViewCell: UITableViewCell {
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    weak var delegate: SenderTableViewCellDelegate?
    
    @IBAction func closeAction(_ sender: Any) {
        delegate?.didCloseAction()
    }
    
    func configure(questionsInfoModel: QuestionsInfoModel) {
        valueLabel.text = questionsInfoModel.value
        if let urlString = questionsInfoModel.avatar {
            avatarImageView.imageFromUrl(urlString: urlString)
        }
    }
}
