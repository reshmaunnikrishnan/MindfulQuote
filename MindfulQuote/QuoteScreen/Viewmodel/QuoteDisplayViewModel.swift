//
//  MindfulQuotesViewModel.swift
//  MindfulQuote
//
//  Created by Reshma Unnikrishnan on 20.09.22.
//

import Foundation

protocol QuoteDisplayViewModelInput {
    func fetchQuote(lang: String, completion: @escaping () -> Void)
    var showAlert: (() -> Void)? { get set }
    var showErrorAlert: (() -> Void)? { get set }
    var quote: Quote? { get set }
    var error: RequestError? { get set }
    var quoteText: String? { get set }
}

final class QuoteDisplayViewModel: QuoteDisplayViewModelInput {    
    
    // MARK: - Properties
    var showAlert: (() -> Void)?
    var showErrorAlert: (() -> Void)?
    
    var error: RequestError? {
        didSet { showErrorAlert?() }
    }
    
    var quote: Quote? {
        didSet {
            showAlert?()
            quoteText = quote?.text
        }
    }
    
    var quoteText: String?
    
    // MARK: - Initialization
    let service: QuoteDisplayServicable
    init(service: QuoteDisplayServicable) {
        self.service = service
    }

    // MARK: - Public Methods
    func fetchQuote(lang: String, completion: @escaping () -> Void)  {
        service.fetchQuote(lang: lang) { quote, error in
            guard let quote = quote else {
                self.error = error
                completion()
                return
            }
            self.quote = quote
            completion()
        }
    }

}

