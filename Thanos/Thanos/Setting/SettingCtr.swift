//
//  SettingCtr.swift
//  Thanos
//
//  Created by kakashi on 7/5/20.
//  Copyright © 2020 BeNguyen. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

fileprivate let APP_ID = ""
fileprivate let APPSTORE_APP = "itms-apps://itunes.apple.com/app/id\(APP_ID)"
open class SettingCtr: ThanosListView<SettingCell, String> {
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(table)
        view.backgroundColor = .white
        table.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        datasource = ["Rate 5*", "Feed back", "More apps"]
    }
    
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else {
                if let url = URL(string: APPSTORE_APP),
                    UIApplication.shared.canOpenURL(url)
                {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        case 1:
            let email = "tranduytu93@gmail.com"
            if let url = URL(string: "mailto:\(email)"),
                UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        default:
            if let url = URL(string: "itms-apps://itunes.apple.com/developer/duytu-tran/id1244491336"),
                UIApplication.shared.canOpenURL(url)
            {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}

open class SettingCell: ThanosListCell<String> {
    open lazy var titleLbl: UILabel = {
        let lbl = UIMaker.makeTitleLbl()
        return lbl
    }()
    
    override open func setupView() {
        super.setupView()
        addSubviews(titleLbl)
        titleLbl.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview().inset(padding)
        }
    }
    
    override open func configCell(_ data: String) {
        titleLbl.text = data
    }
}

