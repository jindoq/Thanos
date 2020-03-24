//
//  UIMaker.swift
//  PAVE
//
//  Created by Duy Tu Tran on 3/11/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation
import UIKit

public let padding: CGFloat = 20
public struct UIMaker {
    public static func makeBtn(text: String? = nil, color: UIColor = .white, fontSize: CGFloat = 17, isBold: Bool = false, bgColor: UIColor = UIColor.Thanos.green) -> ThanosButton {
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
    
    public static func makeLbl(text: String? = nil, color: UIColor = .white, bgColor: UIColor = .clear, fontSize: CGFloat = 17, isBold: Bool = false, align: NSTextAlignment = .center, padding: Bool = false) -> UILabel {
        let lbl = padding ? PaddingLabel() : UILabel()
        lbl.text = text
        lbl.backgroundColor = bgColor
        lbl.textColor = color
        lbl.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        lbl.textAlignment = align
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.createCorner(4)
        return lbl
    }
}

class PaddingLabel: UILabel {
    
    var topInset: CGFloat = padding/2
    var bottomInset: CGFloat = padding/2
    var leftInset: CGFloat = padding
    var rightInset: CGFloat = padding
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
