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
    
    var disposeBag = DisposeBag()
    
    var VM: ResultVMProtocol!
    
    
    var pieChart: PieChartView = {
        let view = PieChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initializeData()
        setupUI()
        pieChart.chartDescription?.text = "What the!?"
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        VM.startDownload()
        pieChart.data = VM.chartData
    }
    

    func initializeData(){
        initializeLoaderObserver(VM.loaderPublisher)
        VM.initializeObservableResultDataAPI().disposed(by: disposeBag)
    }
    
    func setupUI() {
        // AFTER LOADER - SETUP PIE
        self.view.addSubview(pieChart)
        setupConstraints()
    }
    
    func setupConstraints() {
        let constraints = [
            pieChart.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pieChart.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pieChart.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pieChart.heightAnchor.constraint(equalToConstant: 500),
            
            ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
