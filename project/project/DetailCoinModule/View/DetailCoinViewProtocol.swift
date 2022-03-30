//
//  DetailCoinViewProtocol.swift
//  project
//
//  Created by Dzmitry on 23.02.22.
//

import Foundation

protocol DetailCoinViewProtocol: AnyObject {
    
    func setupFields(viewData: CoinTableViewCellViewModel)
    
    func showVC(data: CoinTableViewCellViewModel)
}
