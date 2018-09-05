//
//  ResultCoordinator.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 03/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import UIKit
class ResultCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController
    let controller: ResultViewController
    init (presenter: UINavigationController, data: [String] ){
        self.presenter = presenter        
        let controller = ResultViewController()
        let resultVM = ResultVM(data: data)
        controller.VM = resultVM
        //Add ViewModel initialization.
        self.controller = controller
        
    }
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
    
    
}
