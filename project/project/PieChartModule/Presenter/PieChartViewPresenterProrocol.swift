//
//  PieChartViewPresenterProrocol.swift
//  project
//
//  Created by Dmitry on 23.03.22.
//

import Foundation

protocol PieChartViewPresenterProtocol {
    
    var rawData: [WalletTableViewCellModel] { get set }
    
    func setData(data: [WalletTableViewCellModel])
}
