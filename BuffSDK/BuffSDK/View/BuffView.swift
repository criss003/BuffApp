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
        
    public func showQuestionsView() {
        leadingConstraint.constant = 0
        animateView()
    }
    
    public func hideQuestionsView() {
        leadingConstraint.constant = -self.frame.width
        animateView()
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
        
        viewModel.delegate = self
        viewModel.startMonitoringQuestions()
    }
    
    func animateView() {
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

extension BuffView: BuffViewModelDelegate {

    func modelUpdateDidSucced(buffModel: BuffModel?) {
        questionsView.configureUI(buffModel: buffModel)
        delegate?.shouldShow()
        showQuestionsView()
    }
    
    func modelUpdateDidFail(error: BuffError) {
        delegate?.shouldHide()
        hideQuestionsView()
    }
}
