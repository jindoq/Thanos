//
//  IAPCtr.swift
//  BrainTrainer3
//
//  Created by Duy Tu Tran on 6/30/20.
//  Copyright © 2020 BeNguyen. All rights reserved.
//

import UIKit
import StoreKit

class IAPCtr: ThanosListView<IAPCell, SKProduct>, UITextFieldDelegate {
    var alert: PMAlertController?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Restore", style: .done, target: self, action: #selector(restoreAction))
        view.addSubviews(table)
        view.backgroundColor = .white
        table.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        table.backgroundColor = UIColor.Thanos.superLightGray
        
        IAPProducts.store.requestProducts { (success, products) in
            if success, let arr = products {
                self.datasource = arr
            }
        }
    }
    
    @objc func restoreAction() {
        IAPProducts.store.restorePurchases()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        IAPProducts.store.buyProduct(datasource[indexPath.row])
    }
}

class IAPCell: ThanosListCell<SKProduct> {
    lazy var titleLbl: UILabel = {
        let lbl = UIMaker.makeTitleLbl()
        return lbl
    }()
    
    lazy var contentLbl: UILabel = {
        let lbl = UIMaker.makeContentLbl()
        return lbl
    }()
    
    lazy var icon: UIImageView = {
        let ic = UIImageView()
        ic.contentMode = .scaleAspectFit
        ic.image = UIImage(named: "ic_buy", in: Bundle(for: IAPCtr.self), compatibleWith: nil)
        return ic
    }()
    
    override func setupView() {
        super.setupView()
        let view = UIView()
        view.backgroundColor = .white
        view.createShadow()
        addSubviews(view)
        view.snp.makeConstraints { (maker) in
            maker.leading.top.trailing.equalToSuperview().inset(20)
            maker.bottom.equalToSuperview()
        }
        
        view.addSubviews(titleLbl, contentLbl, icon)
        titleLbl.snp.makeConstraints { (maker) in
            maker.leading.top.equalToSuperview().inset(padding)
            maker.trailing.equalTo(icon.snp.leading).inset(-padding)
        }
        contentLbl.snp.makeConstraints { (maker) in
            maker.leading.bottom.trailing.equalToSuperview().inset(padding)
            maker.top.equalTo(icon.snp.bottom).inset(-12)
        }
        icon.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().inset(padding)
            maker.centerY.equalTo(titleLbl.snp.centerY)
            maker.height.equalTo(50)
            maker.width.equalTo(50*2.5)
        }
    }
    
    override func configCell(_ data: SKProduct) {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = data.priceLocale
        contentLbl.text = data.localizedDescription
        
        titleLbl.text = "\(data.localizedTitle)\n\(currencyFormatter.string(from: NSNumber(value: data.price.floatValue)) ?? "")"
    }
}
