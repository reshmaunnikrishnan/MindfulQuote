//
//  QuoteDisplayService.swift
//  MindfulQuote
//
//  Created by Reshma Unnikrishnan on 20.09.22.
//

import Foundation

protocol QuoteDisplayServicable {
    func fetchQuote(lang: String, completionHandler: @escaping (Quote?, RequestError?) -> Void )
}

struct QuoteDisplayService: DataRequest, QuoteDisplayServicable {
 

    func fetchQuote(lang: String, completionHandler: @escaping (Quote?, RequestError?) -> Void ) {
        var endpoint: Endpoint = Endpoint.fetchQuote(with: lang)
        
        sendRequest(endPoint: endpoint, type: Quote.self) { result in
            switch result {
            case .success(let news):
                completionHandler(news, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
        
        
    }
    

}

