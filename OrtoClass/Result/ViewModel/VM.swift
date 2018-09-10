//
//  VM.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 03/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import Foundation
import RxSwift
import Charts
import RealmSwift
import Realm

enum valueDisctinaryEnum: String {
    case pelvicIncidence = "pelvic_incidence"
    case pelvicTilt = "pelvic_tilt"
    case lumbarLordosisAngle = "lumbar_lordosis_angle"
    case sacralSlope = "sacral_slope"
    case pelvicRadius = "pelvic_radius"
    case degreeSpondylolisthesis = "degree_spondylolisthesis"
    case diagnosis = "Scored Labels"
    case scoreHernia = "Scored Probabilities for Class \"Hernia\""
    case scoreSpon = "Scored Probabilities for Class \"Spondylolisthesis\""
    case scoreNormal = "Scored Probabilities for Class \"Normal\""
}

class ResultVM: ResultVMProtocol{
    var patient: Patient
    var realmServise = RealmSerivce()
    var resultTuple: (name: String, value: String)!
    var errorOccured: PublishSubject<String>
    var loaderPublisher: PublishSubject<Bool>
    var refreshView: PublishSubject<TableRefresh>
    var dataInitialized: PublishSubject<Bool>
    var refreshPublisher: ReplaySubject<Bool>
    var result: ResultPostModel
    var prabillityArray: [PieChartDataEntry]!
    var normalProbability: PieChartDataEntry = PieChartDataEntry(value: 0.125)
    var herniaProbability: PieChartDataEntry = PieChartDataEntry(value: 0.875)
    var spondylolisthesisProbability: PieChartDataEntry = PieChartDataEntry(value: 0)
    var chartDataSet: PieChartDataSet!
    var chartData: PieChartData!
    let colors = [UIColor.blue,UIColor.red, UIColor(red:0.51, green:0.58, blue:0.34, alpha:1.0)]
    
    init(data : Patient) {
        self.errorOccured = PublishSubject()
        self.patient = data
        self.loaderPublisher = PublishSubject()
        self.refreshView = PublishSubject()
        self.dataInitialized = PublishSubject()
        self.refreshPublisher = ReplaySubject<Bool>.create(bufferSize: 1)
        self.result = ResultPostModel(inputs: Inputs(input1: [Input1(pelvicIncidence: Double(data.pelvicIncidence)!, pelvicTilt: Double(data.pelvicTilt)!, lumbarLordosisAngle: Double(data.lumbarLordosis_angle)!, sacralSlope: Double(data.sacralSlope)!, pelvicRadius: Double(data.pelvicRadius)!, degreeSpondylolisthesis: Double(data.degreeSpondylolisthesis)!, input1Class: .empty
            )]), globalParameters: GlobalParameters(appendScoreColumnsToOutput: false))
    }
    
    func initializeObservableResultDataAPI() -> Disposable {
        let resultPostObserver = refreshPublisher.flatMap { [unowned self] (_) -> Observable<POSTJsonResponse> in
            self.loaderPublisher.onNext(true)
            return ResultRepository().postCalculatorResultsObservable(result: self.result)
        }
        return resultPostObserver
            .map({ (response) -> Patient in
                let patient = Patient()
                for data in response.results.output1.first! {
                    if data.key == valueDisctinaryEnum.scoreNormal.rawValue {
                        if let value = data.value  {
                            patient.normalProbability = value
                        }
                    }
                    if data.key == valueDisctinaryEnum.scoreHernia.rawValue {
                        if let value = data.value {
                            patient.herniaProbability = value
                        }
                    }
                    if data.key == valueDisctinaryEnum.scoreSpon.rawValue {
                        if let value = data.value  {
                            patient.spondylolisthesisProbability = value
                        }
                    }
                    if data.key == valueDisctinaryEnum.diagnosis.rawValue {
                        if let value = data.value  {
                            patient.diagnosis = value

                        }
                    }

                }
                return patient
            })
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            
            .subscribe(onNext: {  [unowned self] (resultObject)  in
                self.generateData(resultObject)
                self.loaderPublisher.onNext(false)
                self.dataInitialized.onNext(true)
                }, onError: { (error) in
                    self.errorOccured.onNext(error.localizedDescription)
                    self.loaderPublisher.onNext(false)
            })
    }

    fileprivate func generateData(_ resultObject: (Patient)) {
       try! self.realmServise.realm.write {
                self.patient.herniaProbability = resultObject.herniaProbability
                self.patient.normalProbability = resultObject.normalProbability
                self.patient.spondylolisthesisProbability = resultObject.spondylolisthesisProbability
                self.patient.diagnosis = resultObject.diagnosis
        }


        self.normalProbability = PieChartDataEntry(value: Double(patient.normalProbability)!*100)
        self.herniaProbability = PieChartDataEntry(value: Double(patient.herniaProbability)!*100)
        self.spondylolisthesisProbability = PieChartDataEntry(value: Double(patient.spondylolisthesisProbability)!*100)
        self.resultTuple = (name: patient.diagnosis, value: self.getScore())
        self.normalProbability.label = "Normal"
        self.herniaProbability.label = "Hernia"
        self.spondylolisthesisProbability.label = "Spondylolisthesis"

        self.prabillityArray = [self.normalProbability,self.herniaProbability, self.spondylolisthesisProbability]
        self.chartDataSet = PieChartDataSet(values: self.prabillityArray, label: "Possible outcomes")
        self.chartDataSet.colors = self.colors
        self.chartData = PieChartData(dataSet: self.chartDataSet)
    }
    
    private func getScore() -> String {
        let array = [self.normalProbability.value, self.herniaProbability.value, self.spondylolisthesisProbability.value]
        let max : Double = array.max()!
        return String(max)
    }
    
    func startDownload() {
        self.refreshPublisher.onNext(true)
    }
    
}
protocol ResultVMProtocol: LoaderViewModelProtocol, TableRefreshViewModelProtocol {
    func initializeObservableResultDataAPI() -> Disposable
    var dataInitialized: PublishSubject<Bool> {get}
    func startDownload()
    var patient: Patient {get}
    var resultTuple:(name: String, value: String)! {get}
    var errorOccured: PublishSubject<String> {get}
    var chartData: PieChartData! {get}
    
}
