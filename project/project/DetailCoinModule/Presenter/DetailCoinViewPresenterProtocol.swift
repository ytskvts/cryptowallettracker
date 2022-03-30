//
//  DetailCoinViewPresenterProtocol.swift
//  project
//
//  Created by Dzmitry on 23.02.22.
//

import Foundation

protocol DetailCoinViewPresenterProtocol {
    
    var viewData: CoinTableViewCellViewModel? { get }
    
    func configure(data: CoinTableViewCellViewModel)
    
    func getChartView() -> ChartView?
    
    func addToPortfolioButtonAction()
}
