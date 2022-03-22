//
//  WalletViewProtocol.swift
//  project
//
//  Created by Dzmitry on 1.03.22.
//

import Foundation

enum ColorOfLabel {
    case green
    case red
}

protocol WalletViewProtocol: AnyObject {
    
    
    func configure(totalCost: String, priceChange: String, labelColor: ColorOfLabel)
    
    func tableViewReloadData()
}
