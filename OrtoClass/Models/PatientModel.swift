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
    @objc dynamic var age: String!
    @objc dynamic var pelvicIncidence: String!
    @objc dynamic var pelvicTilt: String!
    @objc dynamic var lumbarLordosis_angle: String!
    @objc dynamic var sacralSlope: String!
    @objc dynamic var pelvicRadius: String!
    @objc dynamic var degreeSpondylolisthesis: String!
    @objc dynamic var diagnosis: String!
    @objc dynamic var spondylolisthesisGrade: String!
    @objc dynamic var normalProbability: String!
    @objc dynamic var herniaProbability: String!
    @objc dynamic var spondylolisthesisProbability: String!
}


