//
//  HomeViewModel.swift
//  Base MVVM Project
//
//  Created by Matija Solić on 04/08/2018.
//  Copyright © 2018 Factory. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

enum ItemsEnum{
    case NAME
    case YEAR
    case PELVIC_INCIDENCE
    case PELVIC_TILT
    case LUMBAR_LORDOSIS_ANGLE
    case SACRAL_SLOPE
    case PELVIC_RADIUS
    case DEGREE_SPONDYLOLISTHESIS
}

enum TableTypes {
    case general
}

typealias ItemsNames = (type:ItemsEnum, name:String)
typealias ItemsNamesArray = Array<ItemsNames>


class NewPatientViewModel: NewPatientViewModelProtocol {
    var newPatient = Patient()
    var realmServise = RealmSerivce()
    var refreshView: PublishSubject<TableRefresh>
    let itemsNameArray : ItemsNamesArray = [(type: .NAME , name: "Name :"),(type: .YEAR, name: "Years :"), (type: .PELVIC_INCIDENCE, name: "Pelvic Independence :"),(type: .PELVIC_TILT, name: "Pelvic Tilt :"),(type: .LUMBAR_LORDOSIS_ANGLE, name: "Lumbar lordosis angle :"),(type: .SACRAL_SLOPE, name: "Sacral Slope"),(type: .PELVIC_RADIUS, name: "Pelvic radius :"),(type: .DEGREE_SPONDYLOLISTHESIS, name: "Degree spondylolisthesis")     ]
    var itemsToPresent: [TableSectionItem<TableTypes, TableTypes, ItemsNames>] = []
    weak var homeCoordinatorDelegate: NewPatientCoordinatorDelegate?
    var values: [String] = ["0","0","0","0","0","0", "Normal"]
    
    
    init() {
        
        for items in self.itemsNameArray{
            let tableItem: [TableItem<TableTypes, ItemsNames>] = [TableItem(type: TableTypes.general, data: items)]
            self.itemsToPresent += [TableSectionItem(type: TableTypes.general, sectionTitle: .empty, footerTitle: .empty, items: tableItem)]
            
        }
        

        self.refreshView = PublishSubject()
    }
    
    func validateAndOpenResultScreen() {

        if (!self.realmServise.create(object: newPatient)){
            // ERROR
        }
        
        homeCoordinatorDelegate?.openResultScreen(dataToSend: self.newPatient)
        print("Button Tapped!")
    }
    
    
    func inputFinished(indexPath: IndexPath, input: String) {
        let dataToSave = itemsToPresent[indexPath.section].items[indexPath.row].data
        switch dataToSave.type {
        case .PELVIC_INCIDENCE:
            if input.isEmpty{
                self.newPatient.pelvicIncidence = .empty
            }else{
                self.newPatient.pelvicIncidence = input
            }
        case .PELVIC_TILT:
            if input.isEmpty{
                self.newPatient.pelvicTilt = .empty
            }else{
                self.newPatient.pelvicTilt = input
            }
        case .LUMBAR_LORDOSIS_ANGLE:
            if input.isEmpty{
                self.newPatient.lumbarLordosis_angle = .empty
            }else{
                self.newPatient.lumbarLordosis_angle = input
            }
        case .SACRAL_SLOPE:
            if input.isEmpty{
                self.newPatient.sacralSlope = .empty
            }else {
                 self.newPatient.sacralSlope = input
            }
           
        case .PELVIC_RADIUS:
            if input.isEmpty{
                self.newPatient.pelvicRadius = .empty
            }else {
                self.newPatient.pelvicRadius = input
            }
            
        case .DEGREE_SPONDYLOLISTHESIS:
            if input.isEmpty{
                self.newPatient.degreeSpondylolisthesis = .empty
            }else {
                self.newPatient.degreeSpondylolisthesis = input
            }
         
        case .NAME:
            self.newPatient.patientName = input
        case .YEAR:
            self.newPatient.age = input
        }
        print(self.values)
    }
    
}

protocol NewPatientViewModelProtocol: TableRefreshViewModelProtocol, TableRowDelegate {
    var itemsToPresent: [TableSectionItem<TableTypes, TableTypes, ItemsNames>] {get}
    var homeCoordinatorDelegate: NewPatientCoordinatorDelegate? {get set}
    var newPatient: Patient {get}
    func validateAndOpenResultScreen()
}

public protocol TableIndexPathDelegate: class {
    func getIndexPath(forTableCell cell: UITableViewCell ) -> IndexPath?
    
}

public protocol TableRowDelegate: class {
    func inputFinished(indexPath:IndexPath ,input: String)
}
