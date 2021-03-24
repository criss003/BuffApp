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
        guard let result = JsonFactory().parseObject(object: BuffDecodable.self, json: buffJson) else {
            XCTFail("Invalid json data")
            return
        }
        
        sut.configure(buffDecodable: result)
        XCTAssertNil(sut.buff!.avatarImageName)
        XCTAssertNotNil(sut.buff!.authorName)
        XCTAssertEqual(sut.buff!.authorName, "Pedro Luz")
        XCTAssertEqual(sut.buff!.countdown, 10)
        XCTAssertEqual(sut.buff!.answers.count, 2)
        XCTAssertEqual(sut.buff!.answers[0], "324324")
        XCTAssertEqual(sut.buff!.answers[1], "wqewqewq")
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
    
    func testErrors() {
        var error = BuffError(errorType: .invalidData)
        XCTAssertEqual(error.title, BuffErrorConstants.invalidDataErrorTitle)
        XCTAssertEqual(error.message, BuffErrorConstants.invalidDataErrorMessage)
        
        error = BuffError(errorType: .failed)
        XCTAssertEqual(error.title, BuffErrorConstants.failedErrorTitle)
        XCTAssertEqual(error.message, BuffErrorConstants.failedErrorMessage)
        
        error = BuffError(error: NSError(domain: "domain", code: 10000, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"]))
        XCTAssertEqual(error.title, BuffErrorConstants.failedErrorTitle)
        XCTAssertEqual(error.message, "Something went wrong")
    }
}
