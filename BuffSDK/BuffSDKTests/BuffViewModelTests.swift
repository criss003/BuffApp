//
//  BuffViewModelTests.swift
//  BuffSDKTests
//
//  Created by Criss on 3/24/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import XCTest
@testable import BuffSDK

class BuffViewModelTests: XCTestCase {
    var sut: BuffViewModel!
    let buffJson = JsonFactory().returnJson("Buff")!
    
    override func setUp() {
        super.setUp()
        sut = BuffViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testModel() {
        guard let results = JsonFactory().parseObject(object: BuffDecodable.self, json: buffJson) else {
            XCTFail("Invalid json data")
            return
        }
        
        sut.buffModel = BuffModel(buffDecodable: results)
        XCTAssertEqual(sut.buffModel!.answers.count, 2)
    }
}
