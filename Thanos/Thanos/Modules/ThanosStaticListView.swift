//
//  PaveStaticListView.swift
//  PAVE
//
//  Created by kakashi on 3/21/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation
import UIKit

public class ThanosStaticListView: ThanosCtr, UITableViewDataSource, UITableViewDelegate {
    lazy var table: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.backgroundColor = UIColor.white
        tb.showsVerticalScrollIndicator = false
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 500
        return tb
    }()
    
    var datasource = [ThanosCell]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return datasource[indexPath.row]
    }
}
