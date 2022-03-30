//
//  DetailCoinViewPresenter.swift
//  project
//
//  Created by Dzmitry on 23.02.22.
//

import Foundation
import SwiftUI

class DetailCoinViewPresenter: DetailCoinViewPresenterProtocol {
    
    weak var view: DetailCoinViewProtocol?
    
    var viewData: CoinTableViewCellViewModel?
    
    
    init(view: DetailCoinViewProtocol) {
        self.view = view
    }

    
    
    func configure(data: CoinTableViewCellViewModel) {
        viewData = data
        guard let viewData = viewData else {return}
        view?.setupFields(viewData: viewData) 
    }
    

    
    func getChartView() -> ChartView? {
        guard let viewData = viewData else {return nil}
        return ChartView(coin: viewData)
    }
    
    func addToPortfolioButtonAction() {
        guard let viewData = viewData else {return}
        view?.showVC(data: viewData)
    }
}
