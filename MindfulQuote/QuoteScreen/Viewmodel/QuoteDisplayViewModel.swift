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
    var error: Error? { get set }
    var quoteText: String { get set }
}

final class QuoteDisplayViewModel: QuoteDisplayViewModelInput {
    
    // MARK: - Properties
    var showAlert: (() -> Void)?
    var showErrorAlert: (() -> Void)?
    
    var error: Error? {
        didSet { showErrorAlert?() }
    }
    
    var quote: Quote? {
        didSet {
            showAlert?()
        }
    }
    
    var quoteText: String {
        return quote?.text ?? ""
    }
    
    // MARK: - Initialization
    let dataRequest: DataRequestProtocol
    init(dataRequest: DataRequestProtocol) {
        self.dataRequest = dataRequest
    }

    // MARK: - Public Methods
    func fetchQuote(lang: String, completion: @escaping () -> Void)  {
        dataRequest.sendRequest(endPoint: Endpoint.fetchSearchGiphy(with: lang), type: Quote.self) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.error = error
                completion()
                print(error)
            case .success(let quote):
                print(quote)
                self?.quote = quote
                completion()

            }
        }
    }

}

