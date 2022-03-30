//
//  WalletViewPresenterProtocol.swift
//  project
//
//  Created by Dzmitry on 1.03.22.
//

import Foundation

protocol WalletViewPresenterProtocol {
    
    var viewCellData: [WalletTableViewCellModel] { get set }
    
    
    func deleteCoinFromPortfolio(index: IndexPath)
    
    func prepareForTransitionToChartScreen()
    
    func getData()
}
