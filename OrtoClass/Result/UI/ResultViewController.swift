//
//  ResultViewController.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 03/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import UIKit
import RxSwift
import Charts

class ResultViewController: UIViewController, LoaderViewProtocol{
    
    let labelFont: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 30)!
    var disposeBag = DisposeBag()
    var VM: ResultVMProtocol!
    
    var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
        
    }()
    
    var pieChart: PieChartView = {
        let view = PieChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.chartDescription?.text = ""
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initializeData()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        VM.startDownload()
        
    }
    
    
    func initializeData(){
        initializeLoaderObserver(VM.loaderPublisher)
        VM.initializeObservableResultDataAPI().disposed(by: disposeBag)
        initializeError()
        initializeDataObserver()
    }
    
    func setupUI() {
        self.view.addSubviews(resultLabel, pieChart)
        setupConstraints()
    }
    
    func setupConstraints() {
        let constraints = [
            
            pieChart.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pieChart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            pieChart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            pieChart.heightAnchor.constraint(equalToConstant: 350),
            
            resultLabel.bottomAnchor.constraint(equalTo: pieChart.topAnchor, constant: 10),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            
            
            ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func initializeError() {
        let errorObserver = VM.errorOccured
        errorObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (event) in
                ErrorAlert().alert(viewToPresent: self, title: .empty, message: event)
            })
            .disposed(by: disposeBag)
    }
    
    func initializeLoaderObserver(_ loaderObservable: Observable<Bool>){
        loaderObservable
            .asDriver(onErrorJustReturn: false)
            .do(onNext: { [unowned self] (showLoader) in
                if(showLoader){
                    self.showLoader()
                }else {
                    
                    self.dismissLoader()
                }
            })
            .drive()
            .disposed(by: disposeBag)
    }
    
    func initializeDataObserver() {
        let observer = VM.dataInitialized
        observer
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (event) in
                let attributes :Dictionary = [NSAttributedStringKey.font : self.labelFont]
                self.resultLabel.attributedText = NSAttributedString(string: "There's \(self.VM.resultTuple.value)% chance that you have \(self.VM.resultTuple.name)", attributes:attributes)
                self.pieChart.data = self.VM.chartData
            })
            .disposed(by: disposeBag)
    }
    
    
}

