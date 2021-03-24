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
        
        sut.configure(buffDecodable: results)
        XCTAssertEqual(sut.buff!.answers.count, 2)
        XCTAssertNotNil(sut.buff!.authorName)
    }
    
    func testId() {
        XCTAssertEqual(sut.idBuff, 1)
        sut.updateId()
        XCTAssertEqual(sut.idBuff, 2)
        sut.updateId()
        XCTAssertEqual(sut.idBuff, 3)
        sut.updateId()
        XCTAssertEqual(sut.idBuff, 4)
        sut.updateId()
        XCTAssertEqual(sut.idBuff, 5)
        sut.updateId()
        XCTAssertEqual(sut.idBuff, 1)
    }
}
