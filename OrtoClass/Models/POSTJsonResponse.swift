//
//  POSTJsonResponse.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 03/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//
import Foundation

struct POSTJsonResponse: Codable {
    let results: Results
    
    enum CodingKeys: String, CodingKey {
        case results = "Results"
    }
}

struct Results: Codable {
    let output1: [[String: String?]]
}

//struct Output1: Codable {
//
//}

//struct Value: Codable {
//    let columnNames: [String]?
//    let columnTypes: [ColumnType]?
//    let values: [[String]]
//
//    enum CodingKeys: String, CodingKey {
//        case columnNames = "ColumnNames"
//        case columnTypes = "ColumnTypes"
//        case values = "Values"
//    }
//}
//
//enum ColumnType: String, Codable {
//    case double = "Double"
//    case string = "String"
//}

