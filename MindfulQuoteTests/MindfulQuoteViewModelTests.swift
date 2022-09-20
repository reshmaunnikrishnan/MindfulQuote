//
//  MindfulQuoteTests.swift
//  MindfulQuoteTests
//
//  Created by Reshma Unnikrishnan on 20.09.22.
//

import XCTest
@testable import MindfulQuote

class MindfulQuoteViewModelTests: XCTestCase {
    var mockService: MockService!
    var sut: QuoteDisplayViewModelInput!

    override func setUp() {
        super.setUp()
        mockService = MockService()
        sut = QuoteDisplayViewModel(service: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        sut = nil
        super.tearDown()
    }
    
    func testFetchQuotesCalled() {
        // When start fetch quote
        sut.fetchQuote(lang: "en") { [weak self] in
            XCTAssertEqual(self?.mockService.isRequestCalled, true)
        }
        
        XCTAssertEqual(mockService.lang, "en")
    }
    
    func testFetchQuotesCalledWithError() {
        // Given
        let error: RequestError = RequestError.invalidURL
        // When start fetch quote
        sut.fetchQuote(lang: "en") {
            XCTAssertEqual(self.mockService.isRequestCalled, true)
        }
        
        mockService.fetchFail(error: error)
        // Sut should load the error value in the `error` property
        XCTAssertNotNil(sut.error)
        XCTAssertEqual(sut.error, error)
    }
    
    func testFetchQuotesCalledWithSuccess() {
        // Given
        sut.fetchQuote(lang: "en") {
            XCTAssertEqual(self.mockService.isRequestCalled, true)
        }

        // When start fetch quote
        mockService.fetchSuccess()

        //then
        XCTAssertEqual(sut.quote?.text, "Breath!!")
        XCTAssertEqual(sut.quote?.id, "12345")
    }
}
