//
//  AppCoordinator.swift
//  Base MVVM Project
//
//  Created by Matija Solić on 04/08/2018.
//  Copyright © 2018 Factory. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator{
    
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    //root navigation controller
    var presenter: UINavigationController
    init(window: UIWindow) {
        self.window = window
        presenter = UINavigationController()
        presenter.navigationBar.barTintColor = UIColor(red:0.12, green:0.77, blue:1.00, alpha:1.0)
        presenter.navigationItem.backBarButtonItem?.tintColor = .white
        presenter.navigationItem.leftBarButtonItem?.tintColor = .white
        

        
    }
    
    func start() {
        window.rootViewController = presenter
        window.makeKeyAndVisible()
        let homeCoordinator = PatientsCoordinator(presenter: presenter) //HomeCoordinator(presenter: presenter)
        addChildCoordinator(childCoordinator: homeCoordinator)
        homeCoordinator.start()
    }
}
