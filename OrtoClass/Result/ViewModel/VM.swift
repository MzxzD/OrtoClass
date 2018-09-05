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



class ResultVM: ResultVMProtocol{
    var resultTuple: (name: String, value: String)!
    static let responseElement = 0
    static let scoredLabelIndex = 10
    static let scoredProbabilityNormalIndex = 9
    static let scoredProbabilitySpondylolisthesisIndex = 8
    static let scoredProbabilityHerniaIndex = 7
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
    
    // RECIVE OBJET TO SENT TO API
    init(data : [String]) {
        self.errorOccured = PublishSubject()
        self.loaderPublisher = PublishSubject()
        self.refreshView = PublishSubject()
        self.dataInitialized = PublishSubject()
        self.refreshPublisher = ReplaySubject<Bool>.create(bufferSize: 1)


        // REPLACE DUMMY OBJECT WITH OBJECT FROM PAST SCREEN
        self.result = ResultPostModel(inputs: Inputs(input1: Input1(columnNames: ["pelvic_incidence",
                                                                                  "pelvic_tilt",
                                                                                  "lumbar_lordosis_angle",
                                                                                  "sacral_slope",
                                                                                  "pelvic_radius",
                                                                                  "degree_spondylolisthesis",
                                                                                  "class"],
                                                                    values: [ data, ]
                                                                    )), globalParameters: GlobalParameters())
    }
    
    func initializeObservableResultDataAPI() -> Disposable {
        let resultPostObserver = refreshPublisher.flatMap { [unowned self] (_) -> Observable<POSTJsonResponse> in
            self.loaderPublisher.onNext(true)
            return ResultRepository().postCalculatorResultsObservable(result: self.result)
        }
        return resultPostObserver
            .map({ (response) -> [String] in
                return response.results.output1.value.values[ResultVM.responseElement]
            })
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (resultArray) in
                self.generateData(resultArray)
                self.loaderPublisher.onNext(false)
            })
    }

    fileprivate func generateData(_ resultArray: ([String])) {
        self.normalProbability = PieChartDataEntry(value: Double(resultArray[ResultVM.scoredProbabilityNormalIndex])!*100)
        self.herniaProbability = PieChartDataEntry(value: Double(resultArray[ResultVM.scoredProbabilityHerniaIndex])!*100)
        self.spondylolisthesisProbability = PieChartDataEntry(value: Double(resultArray[ResultVM.scoredProbabilitySpondylolisthesisIndex])!*100)
        self.normalProbability.label = "Normal"
        self.herniaProbability.label = "Hernia"
        self.spondylolisthesisProbability.label = "Spondylolisthesis"
        self.resultTuple = (name: resultArray[ResultVM.scoredLabelIndex], value: self.getScore())
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
    var resultTuple:(name: String, value: String)! {get}
    var errorOccured: PublishSubject<String>{get}
    var chartData: PieChartData! {get}
    
}
