//
//  HomeCoordinator.swift
//  Base MVVM Project
//
//  Created by Matija Solić on 04/08/2018.
//  Copyright © 2018 Factory. All rights reserved.
//

import UIKit
class NewPatientCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController
    let controller: NewPatientViewController
    init (presenter: UINavigationController){
        self.presenter = presenter
        let controller = NewPatientViewController()
        controller.VM = NewPatientViewModel()
        //Add ViewModel initialization.
        self.controller = controller
        self.controller.VM.homeCoordinatorDelegate = self
       
    }
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
    
    
}


extension NewPatientCoordinator: NewPatientCoordinatorDelegate {
    func openResultScreen(dataToSend: Patient) {
        let resultScreen = ResultCoordinator(presenter: presenter, data: dataToSend)
        resultScreen.start()
        self.addChildCoordinator(childCoordinator: resultScreen)
    }
    
    func viewControllerHasFinished() {
        
    }
    
    
}
