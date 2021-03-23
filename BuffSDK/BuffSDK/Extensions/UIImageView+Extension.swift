//
//  UIImageView+Extension.swift
//  BuffSDK
//
//  Created by Criss on 3/23/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}
