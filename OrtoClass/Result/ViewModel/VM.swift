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
    var errorOccured: PublishSubject<String>
    var loaderPublisher: PublishSubject<Bool>
    var refreshView: PublishSubject<TableRefresh>
    var dataInitialized: PublishSubject<Bool>
    var refreshPublisher: ReplaySubject<Bool>
    var result: ResultPostModel
    var prabillityArray: [PieChartDataEntry]
    var normalProbability: PieChartDataEntry = PieChartDataEntry(value: 0.125)
    var herniaProbability: PieChartDataEntry = PieChartDataEntry(value: 0.875)
    var splendylosisProbability: PieChartDataEntry = PieChartDataEntry(value: 0)
    var chartDataSet: PieChartDataSet
    var chartData: PieChartData
    let colors = [UIColor.blue,UIColor.red, UIColor.yellow]
    
    // RECIVE OBJET TO SENT TO API
    init() {
        self.errorOccured = PublishSubject()
        self.loaderPublisher = PublishSubject()
        self.refreshView = PublishSubject()
        self.dataInitialized = PublishSubject()
        self.refreshPublisher = ReplaySubject<Bool>.create(bufferSize: 1)
        normalProbability.label = "Normal"
        herniaProbability.label = "Hernia"
        splendylosisProbability.label = "Whatever"
        self.prabillityArray = [normalProbability,herniaProbability, splendylosisProbability]
        self.chartDataSet = PieChartDataSet(values: prabillityArray, label: "lol")
        self.chartDataSet.colors = colors
        self.chartData = PieChartData(dataSet: chartDataSet)
        // REPLACE DUMMY OBJECT WITH OBJECT FROM PAST SCREEN
        self.result = ResultPostModel(inputs: Inputs(input1: Input1(columnNames: ["pelvic_incidence",
                                                                                  "pelvic_tilt",
                                                                                  "lumbar_lordosis_angle",
                                                                                  "sacral_slope",
                                                                                  "pelvic_radius",
                                                                                  "degree_spondylolisthesis",
                                                                                  "class"], values:  [
                                                                                    [
                                                                                        "0",
                                                                                        "0",
                                                                                        "0",
                                                                                        "0",
                                                                                        "0",
                                                                                        "0",
                                                                                        "Normal"
                                                                                    ],
                                                                                    ])), globalParameters: GlobalParameters())
    }
    
    
    
    func initializeObservableResultDataAPI() -> Disposable {
        let resultPostObserver = refreshPublisher.flatMap { [unowned self] (_) -> Observable<POSTJsonResponse> in
            self.loaderPublisher.onNext(true)
            return ResultRepository().postCalculatorResultsObservable(result: self.result)
        }
        // MAP AND PICK UP PROBABILITIES AND SAVE THEM INTO VALUES FOR PIE
        return resultPostObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (response) in
                print(response)
                // FINISH LOADER AND SHOW PIE
            })
    }

    func startDownload() {
        self.refreshPublisher.onNext(true)
    }
    
}

protocol ResultVMProtocol: LoaderViewModelProtocol, TableRefreshViewModelProtocol {
    func initializeObservableResultDataAPI() -> Disposable
    var dataInitialized: PublishSubject<Bool> {get}
    func startDownload()
    var errorOccured: PublishSubject<String>{get}
    var chartData: PieChartData {get}
    
}
