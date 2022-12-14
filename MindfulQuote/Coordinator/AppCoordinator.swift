//
//  TopStoriesListViewController.swift
//  TopStories
//
//  Created by Reshma Unnikrishnan on 20.09.22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    private var window: UIWindow?
    var dataStore: DataRequest

    init(window: UIWindow, dataStore: QuoteDisplayService = QuoteDisplayService()) {
        self.window = window
        self.dataStore = dataStore
    }

    var listCoordinator: QuoteDisplayCoordinator!

    @discardableResult
    func start() -> UIViewController {
        listCoordinator = QuoteDisplayCoordinator(service: QuoteDisplayService())
        let mainVC = listCoordinator.start()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        return mainVC
    }
}
