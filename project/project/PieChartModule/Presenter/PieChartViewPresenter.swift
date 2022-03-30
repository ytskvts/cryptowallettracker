//
//  PieChartViewPresenter.swift
//  project
//
//  Created by Dmitry on 23.03.22.
//

import Foundation

class PieChartViewPresenter: PieChartViewPresenterProtocol {
    
    weak var view: PieChartViewProtocol?
    
    let coinModelParser = CoinModelParser()
    
    init(view: PieChartViewProtocol) {
        self.view = view
    }
    
    var rawData: [WalletTableViewCellModel] = [] {
        didSet {
            var totalCost: Double = 0
            for el in rawData {
                let totalCoinPrice = Double(coinModelParser.cutString(data: el.totalCoinPrice)) ?? 0
                totalCost += totalCoinPrice
                view?.addChartDataEntry(cost: totalCoinPrice, symbol: el.symbol)
            }
            
            view?.updateChartData(totalCost: coinModelParser.cutString(data: totalCost))
        }
    }
    
    func setData(data: [WalletTableViewCellModel]) {
        rawData = data
    }
}
