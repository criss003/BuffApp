//
//  BuffService.swift
//  BuffSDK
//
//  Created by Criss on 3/20/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import Foundation

struct BuffServiceConstants {
    static let serviceURL = "https://demo2373134.mockable.io/buffs/1"
    
    static let invalidURLErrorMessage = "Invalid URL"
    static let invalidURLErrorCode = 10001
    static let invalidDataErrorMessage = "Invalid Data"
    static let invalidDataErrorCode = 10002
}

class BuffService {
    
    func fetchBuffs(completionHandler: @escaping (BuffModel) -> Void) {
        
        performRequest(urlString: BuffServiceConstants.serviceURL, errorHandler: { error in
            print(error.localizedDescription)
        }, successHandler: { data in
            do {
                let buff = try JSONDecoder().decode(BuffModel.self, from: data)
                completionHandler(buff)
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
        })
    }
    
    func performRequest(urlString: String,
                        errorHandler: @escaping (_ error: Error) -> Void,
                        successHandler: @escaping (_ data: Data) -> Void) {
        
        guard let url = URL(string: urlString) else {
            errorHandler(NSError(domain: BuffServiceConstants.invalidURLErrorMessage, code: BuffServiceConstants.invalidURLErrorCode, userInfo: nil))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let err = error {
                errorHandler(err)
                return
            }
            
            guard let jsonData = data else {
                errorHandler(NSError(domain: BuffServiceConstants.invalidDataErrorMessage, code: BuffServiceConstants.invalidDataErrorCode, userInfo: nil))
                return
            }
            
            successHandler(jsonData)
            
            }.resume()
    }
}
