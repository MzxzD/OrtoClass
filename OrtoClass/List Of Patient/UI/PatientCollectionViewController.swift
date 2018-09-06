//
//  PatientCollectionViewController.swift
//  OrtoClass
//
//  Created by Mateo Doslic on 06/09/2018.
//  Copyright © 2018 Mateo Doslic. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PatientCollectionViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell: PatientCollectionViewCell = tableView.dequeue(for: indexPath)
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
}
