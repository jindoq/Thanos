//
//  ThanosHeaderListView.swift
//  PUBGTips
//
//  Created by Duy Tu Tran on 3/25/20.
//  Copyright © 2020 Be Nguyen. All rights reserved.
//

import Foundation
import UIKit

open class ThanosHeaderListView<H: ThanosListHeader<B>, B, C: ThanosListCell<T>, T>: ThanosCtr, UITableViewDataSource, UITableViewDelegate {
    open lazy var table: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.backgroundColor = .clear
        tb.showsVerticalScrollIndicator = false
        tb.register(C.self, forCellReuseIdentifier: "Cell")
        tb.register(H.self, forHeaderFooterViewReuseIdentifier: "Header")
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 500
        return tb
    }()
    
    open var datasource = [(header: B, cells: [T])]() {
        didSet {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].cells.count
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? H
        header?.configHeader(datasource[section].header)
        return header
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! C
        cell.configCell(datasource[indexPath.section].cells[indexPath.row])
        return cell
    }
}

open class ThanosHeader: UITableViewHeaderFooterView {
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupView() {}
}

open class ThanosListHeader<B>: ThanosHeader {
    open func configHeader(_ data: B) {}
}

open class ThanosDefaultHeader: ThanosListHeader<String> {
    lazy var titleLbl: UILabel = {
        return UIMaker.makeTitleLbl(text: " ")
    }()
    
    open override func setupView() {
        super.setupView()
        let view = UIView()
        view.backgroundColor = UIColor.Thanos.superLightGray
        addSubviews(view)
        view.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        view.addSubviews(titleLbl)
        titleLbl.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview().inset(padding)
            maker.top.bottom.equalToSuperview().inset(15)
        }
    }
    
    open override func configHeader(_ data: String) {
        titleLbl.text = data
    }
}


