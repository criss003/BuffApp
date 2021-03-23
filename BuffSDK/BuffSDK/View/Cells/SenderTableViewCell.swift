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
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    weak var delegate: SenderTableViewCellDelegate?
    
    @IBAction func closeAction(_ sender: Any) {
        delegate?.didCloseAction()
    }
    
    func configure(rowInfo: (value: String?, avatar: String?)) {
        valueLabel.text = rowInfo.value
        if let urlString = rowInfo.avatar {
            avatarImageView.imageFromUrl(urlString: urlString)
        }
    }
}
