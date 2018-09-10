//
//  HomeCoordinatorDelegate.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 03/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import Foundation

protocol NewPatientCoordinatorDelegate: CoordinatorDelegate {
    func openResultScreen(dataToSend: Patient)
}
