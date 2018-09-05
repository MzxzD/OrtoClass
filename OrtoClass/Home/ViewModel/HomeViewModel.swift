//
//  HomeViewModel.swift
//  Base MVVM Project
//
//  Created by Matija Solić on 04/08/2018.
//  Copyright © 2018 Factory. All rights reserved.
//

import Foundation
import RxSwift

enum ItemsEnum{
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


class HomeViewModel: HomeViewModelProtocol {
    var refreshView: PublishSubject<TableRefresh>
    let itemsNameArray : ItemsNamesArray = [(type: .PELVIC_INCIDENCE, name: "Pelvic Independence :"),(type: .PELVIC_TILT, name: "Pelvic Tilt :"),(type: .LUMBAR_LORDOSIS_ANGLE, name: "Lumbar lordosis angle :"),(type: .SACRAL_SLOPE, name: "Sacral Slope"),(type: .PELVIC_RADIUS, name: "Pelvic radius :"),(type: .DEGREE_SPONDYLOLISTHESIS, name: "Degree spondylolisthesis")     ]
    var itemsToPresent: [TableSectionItem<TableTypes, TableTypes, ItemsNames>] = []
    weak var homeCoordinatorDelegate: HomeCoordinatorDelegate?
    var values: [String] = ["0","0","0","0","0","0", "Normal"]
    
    
    init() {
        
        for items in self.itemsNameArray{
            let tableItem: [TableItem<TableTypes, ItemsNames>] = [TableItem(type: TableTypes.general, data: items)]
            self.itemsToPresent += [TableSectionItem(type: TableTypes.general, sectionTitle: .empty, footerTitle: .empty, items: tableItem)]
            
        }
        

        self.refreshView = PublishSubject()
    }
    
    func validateAndOpenResultScreen() {
//        let validateResultTuple = validateInputData()
//        if (validateResultTuple.value) {
//            fillObjetAndSendToResult()
//        }else {
//            triggerError(errorMessage: validateResultTuple.errorMessage)
//        }
        
        // VALIDATE INPUT WITHIN REASONABLE RANGE
        homeCoordinatorDelegate?.openResultScreen(dataToSend: self.values)
        print("Button Tapped!")
    }
    
    
    func inputFinished(indexPath: IndexPath, input: String) {
        let dataToSave = itemsToPresent[indexPath.section].items[indexPath.row].data
        switch dataToSave.type {
        case .PELVIC_INCIDENCE:
            if input.isEmpty{
            self.values[0] = "0"
            }else{
                self.values[0] = input
            }
        case .PELVIC_TILT:
            if input.isEmpty{
                self.values[1] = "0"
            }else{
                self.values[1] = input

            }
        case .LUMBAR_LORDOSIS_ANGLE:
            if input.isEmpty{
                self.values[2] = "0"
            }else{
                self.values[2] = input
            }
        case .SACRAL_SLOPE:
            if input.isEmpty{
                self.values[3] = "0"
            }else {
                 self.values[3] = input
            }
           
        case .PELVIC_RADIUS:
            if input.isEmpty{
                self.values[4] = "0"
            }else {
                self.values[4] = input
            }
            
        case .DEGREE_SPONDYLOLISTHESIS:
            if input.isEmpty{
                self.values[5] = "0"
            }else {
                self.values[5] = input
            }
         
        }
        print(self.values)
    }
    
}

// ADD DELEGATE TO AUTOMACITALLY FILL DATA WHILE ITS ENTERING

protocol HomeViewModelProtocol: TableRefreshViewModelProtocol, TableRowDelegate {
    var itemsToPresent: [TableSectionItem<TableTypes, TableTypes, ItemsNames>] {get}
    var homeCoordinatorDelegate: HomeCoordinatorDelegate? {get set}
    func validateAndOpenResultScreen()
}

public protocol TableIndexPathDelegate: class {
    func getIndexPath(forTableCell cell: UITableViewCell ) -> IndexPath?
    
}

public protocol TableRowDelegate: class {
    func inputFinished(indexPath:IndexPath ,input: String)
}
