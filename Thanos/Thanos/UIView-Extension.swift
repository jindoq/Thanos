//
//  UIView.swift
//  PAVE
//
//  Created by Duy Tu Tran on 3/17/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public func createCorner(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    public func createBorder(width: CGFloat, color: UIColor = .white) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    public func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
