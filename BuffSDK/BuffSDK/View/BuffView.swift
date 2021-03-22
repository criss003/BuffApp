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

public class BuffView: UIViewNibLoadable {
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
}

extension BuffView: BuffViewModelDelegate {

    func modelUpdateDidSucced() {
        
    }
    
    func modelUpdateDidFail(error: BuffError) {
        
    }
}
