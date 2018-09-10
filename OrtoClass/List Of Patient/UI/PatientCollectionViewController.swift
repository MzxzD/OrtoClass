//
//  PatientCollectionViewController.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 06/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import UIKit
import RxSwift

private let reuseIdentifier = "Cell"

class PatientCollectionViewController: UITableViewController, TableRefreshView, LoaderViewProtocol {
    let disposeBag = DisposeBag()

    var VM: PatientViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initializeData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.title = "OrtoClass"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startGettingDataFromRealm()
    }
    
    func initializeData() {
        initializeRefreshDriver(refreshObservable: VM.refreshView)
        initializeLoaderObserver(VM.loaderPublisher)
        VM.getStoredPatients().disposed(by: disposeBag)

    }
    
//    func initializeRealmObservable() {
//        let observer = VM.dataIsReady
//        observer
//            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] (event) in
//                if event {
//                    self.tableView.reloadData()
//                }
//            }).disposed(by: disposeBag)
//    }

    
    func startGettingDataFromRealm() {
        VM.getDataFromRealm()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VM.patients.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let patientData = VM.patients[indexPath.row]
            let cell: PatientCollectionViewCell = tableView.dequeue(for: indexPath)
            cell.patientName.text = patientData.patientName
            cell.normalProbabilityLabel.text = String(Double(patientData.normalProbability)!*100)+" %"
            cell.spondylolisthesisProbabilityLabel.text = String(Double(patientData.spondylolisthesisProbability)!*100)+" %"
        cell.herniaProbabilityLabel.text = String(Double(patientData.herniaProbability)!*100)+" %"
            return cell
        }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150

    }
    func setupView() {
        view.backgroundColor = .white
        setupTableView()
        
    }
    func  setupTableView() {
        tableView.register(PatientCollectionViewCell.self, forCellReuseIdentifier: PatientCollectionViewCell.identifier)
        self.tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            
        }else {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0)
            self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 55, 0)
            self.tableView.rowHeight = 45
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        VM.openResultScreen(selectedIndex: indexPath)
    }
    
    @objc func addTapped() {
        VM.openNewPatientScreen()
    }
}
