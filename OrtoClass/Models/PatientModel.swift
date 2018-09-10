//
//  PatientModel.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 10/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import Realm
import RealmSwift


class Patient: Object {
    
    @objc dynamic var patientName: String!
    @objc dynamic var age: Int = 0
    @objc dynamic var pelvicIncidence: Int = 0
    @objc dynamic var pelvicTilt: Int = 0
    @objc dynamic var lumbarLordosis_angle: Int = 0
    @objc dynamic var sacralSlope: Int = 0
    @objc dynamic var pelvicRadius: Int = 0
    @objc dynamic var degreeSpondylolisthesis: Int = 0
    @objc dynamic var diagnosis: String!
    @objc dynamic var spondylolisthesisGrade: String!
    @objc dynamic var normalProbability: Double = 0.0
    @objc dynamic var herniaProbability: Double = 0.0
    @objc dynamic var spondylolisthesisProbability: Double = 0.0
}


