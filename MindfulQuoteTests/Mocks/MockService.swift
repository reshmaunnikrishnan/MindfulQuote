//
//  DataRequestTest.swift
//  MindfulQuoteTests
//
//  Created by Reshma Unnikrishnan on 20.09.22.
//

import Foundation
@testable import MindfulQuote

final class MockService: QuoteDisplayServicable {
   
    var isRequestCalled = false
    var lang = ""
    var completionClosure: ((Quote?, RequestError?) -> Void)!

    let quote = Quote(createdAt: "", id: "12345", lang: "en", text: "Breath!!", updatedAt: "")
    func fetchQuote(lang: String, completionHandler: @escaping (Quote?, RequestError?) -> Void) {
        self.lang = lang
        isRequestCalled = true
        completionClosure = completionHandler
    }
    
    func fetchSuccess() {
        completionClosure(quote, nil)
    }
    
    func fetchFail(error: RequestError?) {
        completionClosure(nil, error)
    }
}

