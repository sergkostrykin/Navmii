//
//  AppRouter.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import UIKit

class AppRouter: NSObject {
    
    // MARK: - Properties
    static let shared = AppRouter()
    private var window: UIWindow!
    
    // MARK: - init
    override init () {
        self.window = UIWindow()
        self.window.makeKeyAndVisible()
        super.init()
        showMapViewController()
    }
    
    func showMapViewController() {
        let controller = MapViewController.instantiate()
        let navigation = UINavigationController(rootViewController: controller)
        window.rootViewController = navigation
    }
}
