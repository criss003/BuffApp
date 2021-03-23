//
//  QuestionsView.swift
//  BuffSDK
//
//  Created by Criss on 3/20/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import UIKit

private struct QuestionsViewConstants {
    static let senderTableViewCell = "SenderTableViewCell"
    static let questionTableViewCell = "QuestionTableViewCell"
    static let answerTableViewCell = "AnswerTableViewCell"
}

protocol QuestionsViewDelegate: class {
    func closeAction()
}

@IBDesignable
class QuestionsView: UIViewNibLoadable {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    
    weak var delegate: QuestionsViewDelegate?
    let viewModel = QuestionsViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerCells()
    }
    
    func registerCells() {
        let bundle = Bundle.sdkBundle
        tableView.register(UINib(nibName: QuestionsViewConstants.senderTableViewCell,
                                 bundle: bundle),
                           forCellReuseIdentifier: QuestionsViewConstants.senderTableViewCell)
        tableView.register(UINib(nibName: QuestionsViewConstants.questionTableViewCell,
                                 bundle: bundle),
                           forCellReuseIdentifier: QuestionsViewConstants.questionTableViewCell)
        tableView.register(UINib(nibName: QuestionsViewConstants.answerTableViewCell,
                                 bundle: bundle),
                           forCellReuseIdentifier: QuestionsViewConstants.answerTableViewCell)
    }
    
    func configureUI(buffModel: BuffModel?) {
        viewModel.updateData(buffModel: buffModel)
        tableView.reloadData()
        layoutIfNeeded()
        heightConstraint.constant = tableView.contentSize.height
        layoutIfNeeded()
    }
}

extension QuestionsView: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowInfo = viewModel.rowInfo(at: indexPath)

        if indexPath.row == RowTypeModel.sender.rawValue {
            let cell: SenderTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuestionsViewConstants.senderTableViewCell, for: indexPath) as! SenderTableViewCell
            cell.configure(rowInfo: rowInfo)
            cell.delegate = self
            return cell
        } else if indexPath.row == RowTypeModel.question.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: QuestionsViewConstants.questionTableViewCell, for: indexPath) as! QuestionTableViewCell
            cell.configure(rowInfo: rowInfo)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: QuestionsViewConstants.answerTableViewCell, for: indexPath) as! AnswerTableViewCell
            cell.configure(rowInfo: rowInfo)
            cell.delegate = self
            return cell
        }
    }
}

extension QuestionsView: SenderTableViewCellDelegate {
    func didCloseAction() {
        delegate?.closeAction()
    }
}

extension QuestionsView: AnswerTableViewCellDelegate {
    func didSelectAction() {
        
    }
}
