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
}

@IBDesignable
public class BuffView: UIViewNibLoadable {
    public weak var delegate: BuffViewDelegate?
    
    @IBOutlet weak var questionsView: QuestionsView!
    let viewModel = BuffViewModel()
    
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
    
    func populateView() {
        guard NetworkConnection.isNetworkReachable else {
            UIAlertController.showAlert(message: BuffViewConstants.errorMessage,
                                        title: BuffViewConstants.errorTitle)
            return
        }
        
        viewModel.delegate = self
        viewModel.startMonitoringQuestions()
    }
    
    public func showQuestionsView() {

    }
}

extension BuffView: BuffViewModelDelegate {

    func modelUpdateDidSucced(buffModel: BuffModel?) {
        questionsView.configureUI(buffModel: buffModel)
        delegate?.shouldShow()
    }
    
    func modelUpdateDidFail(error: BuffError) {
        print(error.message)
    }
}
