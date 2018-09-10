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
        let patientVM = PatientViewModel()
        controller.VM = patientVM
        self.controller = controller
        self.controller.VM.patientCoordinatorDelegate = self
    }
    func start() {
        presenter.pushViewController(controller, animated: true)
    }
    
    
}
extension PatientsCoordinator: PatientCoordinatorDelegate{
    func openNewPatientScreen() {
        let newPatientCoordinator = NewPatientCoordinator(presenter: presenter)
        newPatientCoordinator.start()
        addChildCoordinator(childCoordinator: newPatientCoordinator)
    }
    
    func viewControllerHasFinished() {
        
    }
    
    
    
    
}
