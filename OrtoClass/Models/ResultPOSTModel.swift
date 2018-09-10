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
    let appendScoreColumnsToOutput: Bool
    
    enum CodingKeys: String, CodingKey {
        case appendScoreColumnsToOutput = "Append score columns to output"
    }
}

struct Inputs: Codable {
    let input1: [Input1]
}

struct Input1: Codable {
    let pelvicIncidence, pelvicTilt, lumbarLordosisAngle, sacralSlope: Int
    let pelvicRadius, degreeSpondylolisthesis: Int
    let input1Class: String
    
    enum CodingKeys: String, CodingKey {
        case pelvicIncidence = "pelvic_incidence"
        case pelvicTilt = "pelvic_tilt"
        case lumbarLordosisAngle = "lumbar_lordosis_angle"
        case sacralSlope = "sacral_slope"
        case pelvicRadius = "pelvic_radius"
        case degreeSpondylolisthesis = "degree_spondylolisthesis"
        case input1Class = "class"
    }
}
