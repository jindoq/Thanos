//
//  PaveTableCell.swift
//  PAVE
//
//  Created by Duy Tu Tran on 3/18/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation
import UIKit

public class ThanosCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {}
}
