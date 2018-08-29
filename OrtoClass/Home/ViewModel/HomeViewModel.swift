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
//    var resultCoordinatorDelegate: ResultCoordinatorDelegate?
    var refreshView: PublishSubject<TableRefresh>
    let itemsNameArray : ItemsNamesArray = [(type: .PELVIC_INCIDENCE, name: "Pelvic Independence :"),(type: .PELVIC_TILT, name: "Pelvic Tilt :"),(type: .LUMBAR_LORDOSIS_ANGLE, name: "Lumbar lordosis angle :"),(type: .SACRAL_SLOPE, name: "Sacral Slope"),(type: .PELVIC_RADIUS, name: "Pelvic radius :"),(type: .DEGREE_SPONDYLOLISTHESIS, name: "Degree spondylolisthesis")     ]
//    var itemNamesTableItem : [TableItem<TableTypes, ItemsNamesArray>]
    var itemsToPresent: [TableSectionItem<TableTypes, TableTypes, ItemsNames>] = []
    
    
    
    init() {
        
        for items in self.itemsNameArray{
            let tableItem: [TableItem<TableTypes, ItemsNames>] = [TableItem(type: TableTypes.general, data: items)]
            self.itemsToPresent += [TableSectionItem(type: TableTypes.general, sectionTitle: .empty, footerTitle: .empty, items: tableItem)]
            
        }
        

        self.refreshView = PublishSubject()
    }
}


protocol HomeViewModelProtocol: TableRefreshViewModelProtocol {
    var itemsToPresent: [TableSectionItem<TableTypes, TableTypes, ItemsNames>] {get}
//    var priceCoordinatorDelegate: MenuCoordinatorDelegate? {get set}
//    func rowSelected(type: ItemsEnum)
}
