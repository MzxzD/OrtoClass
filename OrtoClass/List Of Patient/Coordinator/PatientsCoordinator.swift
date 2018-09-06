//
//  PatientsCoordinator.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 06/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import UIKit
class PatientsCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController
    let controller: PatientCollectionViewController
    init (presenter: UINavigationController){
        self.presenter = presenter
        let controller = PatientCollectionViewController()
//        let resultVM = ResultVM(data: data)
//        controller.VM = resultVM
        //Add ViewModel initialization.
        self.controller = controller
        
    }
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
    
    
}
