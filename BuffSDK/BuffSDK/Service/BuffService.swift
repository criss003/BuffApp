//
//  BuffService.swift
//  BuffSDK
//
//  Created by Criss on 3/20/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import Foundation
import Alamofire

struct BuffServiceConstants {
    static let serviceURL = "https://demo2373134.mockable.io/buffs/1"
    static let invalidDataErrorMessage = "Invalid Data"
}

class BuffService {
    
    func fetchBuffs(completionHandler: @escaping (BuffModel?) -> Void) {
        
        AF.request(BuffServiceConstants.serviceURL)
          .validate()
          .responseDecodable(of: BuffModel.self) { (response) in
            guard response.error == nil else {
                print(response.error?.localizedDescription ?? "error")
                completionHandler(nil)
                return
            }
            guard let buff = response.value else {
                print(BuffServiceConstants.invalidDataErrorMessage)
                completionHandler(nil)
                return
            }
            completionHandler(buff)
          }
    }
}
