//
//  HomeCoordinator.swift
//  Base MVVM Project
//
//  Created by Matija Solić on 04/08/2018.
//  Copyright © 2018 Factory. All rights reserved.
//

import UIKit
class HomeCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController
    let controller: HomeViewController
    init (presenter: UINavigationController){
        self.presenter = presenter
        let controller = HomeViewController()
        controller.VM = HomeViewModel()
        //Add ViewModel initialization.
        self.controller = controller
        self.controller.VM.homeCoordinatorDelegate = self
       
    }
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
    
    
}


extension HomeCoordinator: HomeCoordinatorDelegate {
    func openResultScreen(dataToSend: [String]) {
        let resultScreen = ResultCoordinator(presenter: presenter, data: dataToSend)
        resultScreen.start()
        self.addChildCoordinator(childCoordinator: resultScreen)
    }
    
    func viewControllerHasFinished() {
        
    }
    
    
}
