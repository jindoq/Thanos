//
//  PaveListView.swift
//  PAVE
//
//  Created by Duy Tu Tran on 3/18/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation
import UIKit

open class ThanosListView<C: ThanosListCell<T>, T>: ThanosCtr, UITableViewDataSource, UITableViewDelegate {
    open lazy var table: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.backgroundColor = .clear
        tb.showsVerticalScrollIndicator = false
        tb.register(C.self, forCellReuseIdentifier: "Cell")
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 500
        tb.tableFooterView = UIView()
        return tb
    }()
    
    open var datasource = [T]() {
        didSet {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! C
        cell.configCell(datasource[indexPath.row])
        return cell
    }
}

