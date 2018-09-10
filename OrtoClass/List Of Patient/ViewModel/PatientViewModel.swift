//
//  PatientViewModel.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 10/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RealmSwift


class PatientViewModel: PatientViewModelProtocol {
    var loaderPublisher: PublishSubject<Bool>
    var patients: [Patient] = []
    var itemsToPresent: [TableSectionItem<TableTypes, TableTypes, Patient>] = []
    var refreshView: PublishSubject<TableRefresh>
    var refreshPublisher: ReplaySubject<Bool>
    var patientCoordinatorDelegate: PatientCoordinatorDelegate?
    var realmTrigger :PublishSubject<Bool>
    var realmServise = RealmSerivce()
    var dataIsReady: PublishSubject<Bool>
    var patientTableItem: [TableItem <TableTypes, Patient>] = []

    
    init() {
        self.dataIsReady = PublishSubject<Bool>()
        self.realmTrigger = PublishSubject<Bool>()
        self.refreshView = PublishSubject()
        self.loaderPublisher = PublishSubject()
        self.refreshPublisher = ReplaySubject<Bool>.create(bufferSize: 1)

    }
    
    
    func getStoredPatients() -> Disposable {
        let realmObaerverTrigger = refreshPublisher
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (event) in
                if event {
                    self.patients.removeAll()
              
                    let realmPatients = self.realmServise.realm.objects(Patient.self)
                    for patient in realmPatients {
                        self.patients.append(patient)
                        self.patientTableItem = [TableItem(type: TableTypes.general, data: patient)]
                    }
                      self.itemsToPresent += [TableSectionItem(type: TableTypes.general, sectionTitle: .empty, footerTitle: .empty, items: self.patientTableItem)]
                    
                    self.refreshView.onNext(TableRefresh.complete)
                    self.loaderPublisher.onNext(false)
                    self.dataIsReady.onNext(true)
                }
            })
        return realmObaerverTrigger
    }
    
    func getDataFromRealm() {
        self.refreshPublisher.onNext(true)
    }
    
    func openNewPatientScreen() {
        patientCoordinatorDelegate?.openNewPatientScreen()
    }
    
    
    
}


protocol PatientViewModelProtocol: TableRefreshViewModelProtocol, LoaderViewModelProtocol {
    var patientCoordinatorDelegate: PatientCoordinatorDelegate? {get set}
    func getStoredPatients() -> Disposable
     func getDataFromRealm()
    var realmTrigger : PublishSubject<Bool> {get}
    var dataIsReady : PublishSubject<Bool> {get}
    var patients: [Patient] {get}
    var itemsToPresent: [TableSectionItem<TableTypes, TableTypes, Patient>] {get}


    func openNewPatientScreen()
}
