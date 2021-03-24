//
//  BuffView.swift
//  BuffSDK
//
//  Created by Eleftherios Charitou on 10/06/2020.
//  Copyright © 2020 BuffUp. All rights reserved.
//

import UIKit

struct BuffViewConstants {
    static let errorTitle = "Error"
    static let errorMessage = "You have no internet connection."
    static let animationDuration = 0.5
}

public protocol BuffViewDelegate: class {
    func shouldShow()
    func shouldHide()
}

@IBDesignable
public class BuffView: UIViewNibLoadable {
    public weak var delegate: BuffViewDelegate?
    
    @IBOutlet private weak var questionsView: QuestionsView!
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    
    private let viewModel = BuffViewModel()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        populateView()
    }
}

private extension BuffView {
    func populateView() {
        guard NetworkConnection.isNetworkReachable else {
            UIAlertController.showAlert(message: BuffViewConstants.errorMessage,
                                        title: BuffViewConstants.errorTitle)
            return
        }
        
        leadingConstraint.constant = -frame.width
        questionsView.delegate = self
        viewModel.delegate = self
        viewModel.startMonitoringQuestions()
    }
    
    func showQuestionsView() {
        delegate?.shouldShow()
        leadingConstraint.constant = 0
        UIView.animate(withDuration: BuffViewConstants.animationDuration) {
            self.questionsView.alpha = 1
            self.layoutIfNeeded()
        }
    }
    
    func hideQuestionsView() {
        leadingConstraint.constant = -frame.width
        UIView.animate(withDuration: BuffViewConstants.animationDuration, animations: {
            self.questionsView.alpha = 0
            self.layoutIfNeeded()
        }, completion: { _ in
            self.delegate?.shouldHide()
        })
    }
}

extension BuffView: BuffViewModelDelegate {

    func modelUpdateDidSucced(buffModel: BuffModel?) {
        questionsView.configureUI(buffModel: buffModel)
        showQuestionsView()
    }
    
    func modelUpdateDidFail(error: BuffError) {
        hideQuestionsView()
    }
}

extension BuffView: QuestionsViewDelegate {
    func closeAction() {
        hideQuestionsView()
    }
}
