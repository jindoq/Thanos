//
//  PaveCtr.swift
//  PAVE
//
//  Created by Duy Tu Tran on 3/18/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation
import UIKit

class ThanosCtr: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
}

extension UIViewController {
    func present(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
}
