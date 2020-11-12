//
//  PaveCtr.swift
//  PAVE
//
//  Created by Duy Tu Tran on 3/18/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation
import UIKit

open class ThanosCtr: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let views = navigationController?.viewControllers, views.count >= 2 {
            setupAds()
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAdmobBannerIfNeed()
    }
    
    open func showAdmobBannerIfNeed() {
        //bannerView.isHidden = IAPProducts.store.isProductPurchased(IAPProducts.removeAds)
    }
    
    @objc open func showAds() {
//        AdsManager.share.showAdmodInterstital(vc: self) {
//            DispatchQueue.main.async {
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
    }

    open func setupAds() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back", in: Bundle(for: ThanosCtr.self), compatibleWith: nil), style: .done, target: self, action: #selector(showAds))
    }

    open func setupSetting() {
        let shopBtn = UIBarButtonItem(image: UIImage(named: "ic_shop", in: Bundle(for: ThanosCtr.self), compatibleWith: nil), style: .done, target: self, action: #selector(shoppingAction))
        let settingBtn = UIBarButtonItem(image: UIImage(named: "ic_setting", in: Bundle(for: ThanosCtr.self), compatibleWith: nil), style: .done, target: self, action: #selector(settingAction))
        navigationItem.rightBarButtonItem = shopBtn
        navigationItem.leftBarButtonItem = settingBtn
    }

    @objc open func shoppingAction() {
        let vc = IAPCtr()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc open func settingAction() {
        let vc = SettingCtr()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
