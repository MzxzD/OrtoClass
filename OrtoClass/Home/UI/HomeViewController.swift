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

    
    let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.titleLabel.text = "Klasifikacija Ortopedskih Pacijenata"
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.title = "OrtoClass"

    }

    func setupView() {
        view.backgroundColor = .white
        let tableContentView = UIView()
        view.addSubviews(tableContentView)
        tableContentView.frame = view.bounds
        tableContentView.backgroundColor = .clear
        tableContentView.addSubview(tableView)
        tableView.frame = tableContentView.bounds
        setupTableView()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.register(CellHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: CellHeaderFooterView.identifier)
        tableView.tableFooterView = UIView()
        if #available(iOS 11.0, *) {
        }else {
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 44
            
        }
    }

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
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
        let dataForDisplay = VM.itemsToPresent[indexPath.section].items[indexPath.row].data
//        cell.unitLabel.text = dataForDisplay.name
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedValue = VM.itemsToPresent[indexPath.section].items[indexPath.row].data
//        self.menuViewModel.rowSelected(type: selectedValue.type)
    }
}
