//
//  UIColor-Extension.swift
//  ThanhAn
//
//  Created by Duy Tu Tran on 3/3/20.
//  Copyright © 2020 Tran Duy Tu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public struct Thanos {
        public static let green = UIColor.color(hex: "2ECC71")
        public static let red = UIColor.color(hex: "E74C3C")
        public static let orange = UIColor.color(hex: "E67E22")
        public static let yellow = UIColor.color(hex: "F1C40F")
        public static let blue = UIColor.color(hex: "3498DB")
        public static let purple = UIColor.color(hex: "9B59B6")
        public static let gray = UIColor.color(hex: "95A5A6")
        public static let lightGray = UIColor.color(hex: "CCCCCC")
        public static let superLightGray = UIColor.color(hex: "ECF0F1")
    }
    
    func adjustBrightness(_ amount:CGFloat) -> UIColor {
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            brightness += (amount-1.0)
            brightness = max(min(brightness, 1.0), 0.0)
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        }
        return self
    }
    
    static func color(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
    
    static func color(hex: String, alpha: CGFloat = 1) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
