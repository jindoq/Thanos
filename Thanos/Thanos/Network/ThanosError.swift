//
//  PaveError.swift
//  PAVE
//
//  Created by Duy Tu Tran on 3/19/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation

struct ThanosError {
    var code: Int
    var message: String?
    
    init(code: Int, message: String? = nil) {
        self.code = code
        self.message = message
    }
    
}
