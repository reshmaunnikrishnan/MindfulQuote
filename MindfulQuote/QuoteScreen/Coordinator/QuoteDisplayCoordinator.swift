//
//  QuoteListCoordinator.swift
//  MindfulQuote
//
//  Created by Reshma Unnikrishnan on 20.09.22.
//

import Foundation
import UIKit

class QuoteDisplayCoordinator: Coordinator {
    var rootViewController: UINavigationController!
    var service: QuoteDisplayServicable

    init(service: QuoteDisplayServicable) {
        self.service = service
    }

    func start() -> UIViewController {
        let viewModel = QuoteDisplayViewModel(service: service)
        let quoteVC = QuoteDisplayViewController(viewModel: viewModel)
        rootViewController = UINavigationController(rootViewController: quoteVC)
        return rootViewController
    }
}
