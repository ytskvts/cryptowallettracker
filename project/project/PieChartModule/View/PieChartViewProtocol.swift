//
//  PieChartViewProtocol.swift
//  project
//
//  Created by Dmitry on 23.03.22.
//

import Foundation

protocol PieChartViewProtocol: AnyObject {
    
    func configure(data: [WalletTableViewCellModel])
    
    func updateChartData(totalCost: String)
    
    func addChartDataEntry(cost: Double, symbol: String)
}
