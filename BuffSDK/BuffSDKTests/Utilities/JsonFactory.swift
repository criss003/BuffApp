//
//  JsonFactory.swift
//  BuffSDKTests
//
//  Created by Criss on 3/24/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import Foundation
@testable import BuffSDK

class JsonFactory {
    func returnJson(_ name: String) -> [String: AnyObject]? {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String: AnyObject] {
                    return jsonResult
                }
            } catch {
                return nil
            }
        }
        return nil
    }
    
    func parseObject<T: Decodable>(object: T.Type, json: [String: Any]) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json as Any, options: .prettyPrinted)
            let decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedObject
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
}
