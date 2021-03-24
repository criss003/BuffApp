//
//  QuestionsViewModelTests.swift
//  BuffSDKTests
//
//  Created by Criss on 3/24/21.
//  Copyright © 2021 BuffUp. All rights reserved.
//

import XCTest
@testable import BuffSDK

class QuestionsViewModelTests: XCTestCase {
    var sut: QuestionsViewModel!
    let buffJson = JsonFactory().returnJson("Buff")!
    
    override func setUp() {
        super.setUp()
        sut = QuestionsViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testRows() {
        guard let result = JsonFactory().parseObject(object: BuffDecodable.self, json: buffJson) else {
            XCTFail("Invalid json data")
            return
        }
        
        let buffModel = BuffModel(buffDecodable: result)
        XCTAssertFalse(sut.answerIsSelected)
        sut.answerIsSelected = true
        XCTAssertTrue(sut.answerIsSelected)
        
        sut.updateData(buffModel: buffModel)
        XCTAssertFalse(sut.answerIsSelected)
        
        XCTAssertEqual(sut.numberOfRows(), 4)
        
        var rowInfo = sut.rowInfo(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(rowInfo.value, buffModel.authorName)
        
        rowInfo = sut.rowInfo(at: IndexPath(row: 1, section: 0))
        XCTAssertEqual(rowInfo.value, buffModel.question)
        
        rowInfo = sut.rowInfo(at: IndexPath(row: 2, section: 0))
        XCTAssertEqual(rowInfo.value, buffModel.answers[0])
        
        rowInfo = sut.rowInfo(at: IndexPath(row: 3, section: 0))
        XCTAssertEqual(rowInfo.value, buffModel.answers[1])
    }
}
