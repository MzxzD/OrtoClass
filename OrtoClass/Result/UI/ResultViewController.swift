//
//  ResultViewController.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 03/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import UIKit
import RxSwift

class ResultViewController: UIViewController,TableRefreshView, LoaderViewProtocol{
    var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    var VM: ResultVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
         initializeData()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        VM.startDownload()
    }
    

    func initializeData(){
        initializeRefreshDriver(refreshObservable: VM.refreshView)
        initializeLoaderObserver(VM.loaderPublisher)
        VM.initializeObservableResultDataAPI().disposed(by: disposeBag)
    }
}
