//
//  GPXParserServiceTests.swift
//  NavmiiTests
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import XCTest
@testable import Navmii

final class GPXParserServiceTests: XCTestCase {

    private let parser = GPXParserService()
    
    func testValidFilePath() {
        let expectation = self.expectation(description: "GPXParserService Test Result Expectation")
        let filePath = MockFactory.validGPXFile
        parser.parse(filePath) { result, error in
            if error != nil {
                XCTFail()
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10)
    }

    func testInvalidFilePath() {
        let expectation = self.expectation(description: "GPXParserService Test Result Expectation")
        let filePath = MockFactory.invalidGPXFile
        parser.parse(filePath) { result, error in
            if error == nil {
                XCTFail()
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10)
    }
    
    func testRemoteFilePath() {
        let expectation = self.expectation(description: "GPXParserService Test Result Expectation")
        let filePath = MockFactory.remoteGPXFile
        parser.parse(filePath) { result, error in
            if error != nil {
                XCTFail()
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10)
    }

    func testInvalidRemoteFilePath() {
        let expectation = self.expectation(description: "GPXParserService Test Result Expectation")
        let filePath = MockFactory.invalidRemoteGPXFile
        parser.parse(filePath) { result, error in
            if error == nil {
                XCTFail()
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10)
    }


}
