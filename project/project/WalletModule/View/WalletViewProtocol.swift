//
//  WalletViewProtocol.swift
//  project
//
//  Created by Dzmitry on 1.03.22.
//

import Foundation

protocol WalletViewProtocol: AnyObject {
    
    func configureForTransition(model: FirebaseModel)
    
    func configure(totalCost: String, priceChange: String)
}
