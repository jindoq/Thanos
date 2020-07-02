//
//  PaveCtr.swift
//  PAVE
//
//  Created by Duy Tu Tran on 3/18/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

open class ThanosCtr: UIViewController {
    open func setupAds() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back", in: Bundle(for: ThanosCtr.self), compatibleWith: nil), style: .done, target: self, action: #selector(showAds))
    }
    
    @objc open func showAds() {}
}

extension UIViewController {
    open func present(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    open func push(_ vc: UIViewController) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
