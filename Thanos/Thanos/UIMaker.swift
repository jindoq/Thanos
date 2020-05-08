//
//  UIMaker.swift
//  PAVE
//
//  Created by Duy Tu Tran on 3/11/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation
import UIKit

public let padding: CGFloat = 16
public struct UIMaker {
    public static func makeActionBtn(text: String? = nil, color: UIColor = .white, fontSize: CGFloat = 16, isBold: Bool = false, bgColor: UIColor = UIColor.Thanos.green) -> ThanosButton {
        let btn = ThanosButton()
        btn.titleLabel?.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        btn.setTitleColor(color, for: .normal)
        btn.setTitle(text, for: .normal)
        btn.backgroundColor = bgColor
        btn.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding*2, bottom: padding, right: padding*2)
        btn.rippleBackgroundColor = bgColor.adjustBrightness(1.5)
        btn.rippleColor = bgColor.adjustBrightness(0.9)
        return btn
    }
    
    public static func makeTitleLbl(text: String? = nil, fontSize: CGFloat = 16, color: UIColor = .black, bgColor: UIColor = .clear, align: NSTextAlignment = .left) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.backgroundColor = bgColor
        lbl.textColor = color
        lbl.font = UIFont.boldSystemFont(ofSize: fontSize)
        lbl.textAlignment = align
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }
    
    public static func makeContentLbl(text: String? = nil, fontSize: CGFloat = 16, color: UIColor = .black, bgColor: UIColor = .clear, align: NSTextAlignment = .left) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.backgroundColor = bgColor
        lbl.textColor = color
        lbl.font = UIFont.systemFont(ofSize: fontSize)
        lbl.textAlignment = align
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }
}

