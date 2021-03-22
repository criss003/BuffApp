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
    static let serviceURL = "https://demo2373134.mockable.io/buffs/"
}

class BuffService {
    
    func fetchBuffs(id: Int,
                    errorHandler: @escaping (_ error: BuffError) -> Void,
                    successHandler: @escaping (_ data: BuffModel) -> Void) {
        
        let urlString = BuffServiceConstants.serviceURL + String(id)
        AF.request(urlString)
          .validate()
          .responseDecodable(of: BuffModel.self) { (response) in
            guard response.error == nil else {
                errorHandler(BuffError(error: response.error))
                return
            }
            guard let buff = response.value else {
                errorHandler(BuffError(errorType: .invalidData))
                return
            }
            successHandler(buff)
          }
    }
}
