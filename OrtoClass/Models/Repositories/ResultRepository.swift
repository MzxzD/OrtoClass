//
//  ResultRepository.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 03/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class ResultRepository: ResultsRepositoryProtocol {
    let url = "https://ussouthcentral.services.azureml.net/workspaces/cc0531fc3664458684a8eb62ec57fc33/services/cca9b4e6ac064e99a30e639a7fca6e88/execute?api-version=2.0&details=true)"
    let headers : HTTPHeaders = ["Authorization": "Bearer oKPbeu63h+JFpgdSH31N5SWhrgWaGd1vblCO23Dy9fwtZV76MwF8u+w7a7FSpgTPFaPJAUxJMOgyzbEPk6wErw==", "Content-Type":"application/json"]
    func postCalculatorResultsObservable(result: ResultPostModel) -> Observable<POSTJsonResponse> {
        let encodedData = try! JSONEncoder().encode(result)
        let params: Parameters
        do {
            params = (try JSONSerialization.jsonObject(with: encodedData, options: []) as? [String: Any])!
        } catch {
            params = [:]
        }
        
        return RestManager.requestObservable(url: url, method: .post, params: params, headers: headers, encoding: JSONEncoding.default)
    }
    
    
}

protocol ResultsRepositoryProtocol {
    func postCalculatorResultsObservable( result: ResultPostModel) -> Observable<POSTJsonResponse>
    
    
}
