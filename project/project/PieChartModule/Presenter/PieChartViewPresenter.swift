//
//  PieChartViewPresenter.swift
//  project
//
//  Created by Dmitry on 23.03.22.
//

import Foundation

class PieChartViewPresenter: PieChartViewPresenterProtocol {
    
    weak var view: PieChartViewProtocol?
    
    init(view: PieChartViewProtocol) {
        self.view = view
    }
    
    var rawData = [WalletTableViewCellModel]()
    
    func setData(data: [WalletTableViewCellModel]) {
        rawData = data
    }
}
