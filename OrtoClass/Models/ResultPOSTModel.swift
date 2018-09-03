//
//  ResultPOSTModel.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 03/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import Foundation

struct ResultPostModel: Codable {
    let inputs: Inputs
    let globalParameters: GlobalParameters
    
    enum CodingKeys: String, CodingKey {
        case inputs = "Inputs"
        case globalParameters = "GlobalParameters"
    }
}

struct GlobalParameters: Codable {
}

struct Inputs: Codable {
    let input1: Input1
}

struct Input1: Codable {
    let columnNames: [String]
    let values: [[String]]
    
    enum CodingKeys: String, CodingKey {
        case columnNames = "ColumnNames"
        case values = "Values"
    }
}
