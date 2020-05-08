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
    public func createCorner(_ radius: CGFloat = 7) {
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
    
    public func createShadow(radius: CGFloat = 7, color: UIColor = UIColor.lightGray) {
        layer.cornerRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
    }
}
