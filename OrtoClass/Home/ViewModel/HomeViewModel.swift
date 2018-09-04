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
        homeCoordinatorDelegate?.openResultScreen()
        print("Button Tapped!")
    }
    
}

// ADD DELEGATE TO AUTOMACITALLY FILL DATA WHILE ITS ENTERING

protocol HomeViewModelProtocol: TableRefreshViewModelProtocol {
    var itemsToPresent: [TableSectionItem<TableTypes, TableTypes, ItemsNames>] {get}
    var homeCoordinatorDelegate: HomeCoordinatorDelegate? {get set}
    func validateAndOpenResultScreen()
}
