//
//  HomeViewController.swift
//  Base MVVM Project
//
//  Created by Matija Solić on 04/08/2018.
//  Copyright © 2018 Factory. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController, TableRefreshView {

    
    
    var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    var disposeBag = DisposeBag()
    var VM: HomeViewModelProtocol!

    
    let calculateFooterView: CalculateFooterView = {
        let footerView =  CalculateFooterView()
        footerView.translatesAutoresizingMaskIntoConstraints = false
        return footerView
    }()
    
    let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.titleLabel.text = "Klasifikacija Ortopedskih Pacijenata"
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        calculateFooterView.validateAndOpenResultScreen = self
        self.title = "OrtoClass"
        self.hideKeyboardWhenTappedAround()

    }

    func setupView() {
        view.backgroundColor = .white
        let tableContentView = UIView()
        view.addSubviews(headerView,tableContentView, calculateFooterView)
        tableContentView.frame = view.bounds
        tableContentView.backgroundColor = .clear
        tableContentView.addSubview(tableView)
        tableView.frame = tableContentView.bounds
        setupTableView()
        setupConstraints()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.register(CellHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: CellHeaderFooterView.identifier)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
        }else {
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 44
            
        }
    }
    
    func setupConstraints(){
        let constraints = [
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: calculateFooterView.topAnchor, constant: 15),
            calculateFooterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calculateFooterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calculateFooterView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            calculateFooterView.heightAnchor.constraint(equalToConstant: 50),
            ]
        
        NSLayoutConstraint.activate(constraints)
    }

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource,TableIndexPathDelegate{

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return VM.itemsToPresent.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VM.itemsToPresent[section].items.count
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: CellHeaderFooterView = tableView.dequeueHeaderFooterView()
        let sectionTitle = VM.itemsToPresent[section].items[0].data
        header.sectionTitleLabel.text = sectionTitle.name
        
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.dequeue(for: indexPath)
//        let dataForDisplay = VM.itemsToPresent[indexPath.section].items[indexPath.row].data
        cell.setupTextFieldChangeObserver()
        cell.tableRowDelegate = VM
        cell.tableIndexPathDelegate = self
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedValue = VM.itemsToPresent[indexPath.section].items[indexPath.row].data
//        self.menuViewModel.rowSelected(type: selectedValue.type)
    }
}

extension HomeViewController: ValidateAndOpenResultScreenDelegate {
    func calculateButtonTapped() {
        VM.validateAndOpenResultScreen()
    }
    
    func getIndexPath(forTableCell cell: UITableViewCell) -> IndexPath? {
        return tableView.indexPath(for: cell)
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

