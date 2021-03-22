//
//  QuestionsView.swift
//  BuffSDK
//
//  Created by Criss on 3/20/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import UIKit

private struct QuestionsViewConstants {
    static let title = "title"
}

protocol QuestionsViewDelegate: class {
    func didRequestAction(questionsView: QuestionsView)
}

@IBDesignable
class QuestionsView: UIViewNibLoadable {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    
    func configureUI() {
        tableView.reloadData()
        heightConstraint.constant = tableView.contentSize.height
    }
}

extension QuestionsView: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = "aa"
        return cell
        
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailsViewControllerConstants.contactDetailsAvatarCellIdentifier, for: indexPath) as! ContactDetailAvatarTableViewCell
//            cell.configure(rowInfo: viewModel.rowInfo(at: indexPath))
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailsViewControllerConstants.contactDetailsCellIdentifier, for: indexPath) as! ContactDetailTableViewCell
//            cell.configure(rowInfo: viewModel.rowInfo(at: indexPath))
//            return cell
//        }
    }

}
