//
//  RealmRepository.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 10/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

class RealmSerivce {
    var realm = try! Realm()
    let errorOccured = PublishSubject<Bool>()
    
    func create<T: Object >(object: T) -> Bool {
        do{
            try realm.write {
                realm.add(object)
            }
        }catch {
            return false
        }
        return true
    }
    
    func delete<T: Patient>(object: T) -> Bool{
        do {
            try realm.write {
                realm.delete(realm.objects(Patient.self).filter("patientName=%@", object.patientName!))
            }
            
        } catch {
            return false
        }
        return true
    }
    
    func getCityLocations() -> (Observable<[Patient]>){
        var patients: [Patient] = []
        let realmPatients = self.realm.objects(Patient.self)
        for patient in realmPatients {
            patients += [patient]
        }
        return Observable.just(patients)
    }
    
}

