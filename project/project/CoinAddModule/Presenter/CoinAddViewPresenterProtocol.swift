//
//  CoinAddViewPresenterProtocol.swift
//  project
//
//  Created by Dzmitry on 26.02.22.
//

import Foundation

protocol CoinAddViewPresenterProtocol {
    
    var viewData: CoinTableViewCellViewModel? { get }
    
    func configure(with data: CoinTableViewCellViewModel)
    
    func alertAction(price: String?, quantity: String?)
    
}
