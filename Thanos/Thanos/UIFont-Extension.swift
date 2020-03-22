//
//  UIFont-Extension.swift
//  PAVE
//
//  Created by Duy Tu Tran on 3/17/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation
import UIKit

enum FontError: Error {
  case invalidFontFile
  case fontPathNotFound
  case initFontError
  case registerFailed
}

class GetBundle {}

extension UIFont {
    static func register(fileNameString: String, type: String) throws {
        let frameworkBundle = Bundle(for: GetBundle.self)
        guard let resourceBundleURL = frameworkBundle.path(forResource: "Font/" + fileNameString, ofType: type) else {
            throw FontError.fontPathNotFound
        }
        guard let fontData = NSData(contentsOfFile: resourceBundleURL),    let dataProvider = CGDataProvider.init(data: fontData) else {
            throw FontError.invalidFontFile
        }
        guard let fontRef = CGFont.init(dataProvider) else {
            throw FontError.initFontError
        }
        var errorRef: Unmanaged<CFError>? = nil
        guard CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) else   {
            throw FontError.registerFailed
        }
    }
    
    static func registerFonts() {
        try! UIFont.register(fileNameString: "Roboto-Bold", type: "ttf")
        try! UIFont.register(fileNameString: "Roboto-Medium", type: "ttf")
    }
    
    static func regular(_ fontSize: CGFloat = 17) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: fontSize)!
    }
    
    static func bold(_ fontSize: CGFloat = 17) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: fontSize)!
    }

}


