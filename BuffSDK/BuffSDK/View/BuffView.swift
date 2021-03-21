//
//  BuffView.swift
//  BuffSDK
//
//  Created by Eleftherios Charitou on 10/06/2020.
//  Copyright © 2020 BuffUp. All rights reserved.
//

import UIKit

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
            UIAlertController.showAlert(message: BuffViewModelConstants.errorMessage,
                                        title: BuffViewModelConstants.errorTitle)
            return
        }
        
//        activityIndicatorView.startAnimating()
//        activityIndicatorView.center = view.center
        
        viewModel.delegate = self
        viewModel.performModelUpdate()
    }
}

extension BuffView: BuffViewModelDelegate {

    func modelUpdateDidFinish() {
        DispatchQueue.main.async {
//            self.activityIndicatorView.stopAnimating()
//            self.tableView.reloadData()
        }
    }
}
