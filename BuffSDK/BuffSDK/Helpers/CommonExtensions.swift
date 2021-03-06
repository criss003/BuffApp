//
//  CommonExtensions.swift
//  ContactsListApp
//
//  Created by Criss on 11/8/20.
//  Copyright © 2020 Criss. All rights reserved.
//

import UIKit
import Alamofire

struct CommonExtensionsConstants {
    static let confirmation = "OK"
}

class NetworkConnection {
    
    static var isNetworkReachable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

extension UIAlertController {

    static func showAlert(message: String?,
                          title: String?,
                          confirmationTitle: String = CommonExtensionsConstants.confirmation,
                          confirmationStyle: UIAlertAction.Style = .cancel,
                          handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirmationTitle,
                                      style: confirmationStyle, handler: handler))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
