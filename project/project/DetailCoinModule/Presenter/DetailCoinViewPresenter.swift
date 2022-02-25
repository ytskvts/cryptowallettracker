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
    
//    var row: Int?
    
//    var viewData: CoinTableViewCellViewModel? {
//        didSet {
//            if oldValue != nil {
//                if isUpdating {
//                    //CoinListViewPresenter.viewData[row] = viewData
//                }
//
//            }
//        }
//    }
    
    
    
    var viewData: CoinTableViewCellViewModel?
    
    
    init(view: DetailCoinViewProtocol) {
        self.view = view
    }
//    func configure(data: CoinTableViewCellViewModel) {
//        viewData = data
//        //row = row
//        guard let viewData = viewData else {return}
//        view?.detailCoinView.configureDetailVC(with: viewData)
//    }
    
    
    func configure(data: CoinTableViewCellViewModel) {
        viewData = data
        guard let viewData = viewData else {return}
        view?.setupFields(viewData: viewData) // либо вообще в дидсет у вьюдата вставить это
    }
    
    #warning("zavtra sdelatb")
//    func configure(data: CoinTableViewCellViewModel) {
//        viewData = data
//        guard let viewData = viewData else {return}
//        let detailCoinView = DetailCoinView()
//        detailCoinView.configureDetailVC(with: viewData)
//        view?.setupView(detailCoinView: detailCoinView)
//    }
    
    func getChartView() -> ChartView? {
        guard let viewData = viewData else {return nil}
        return ChartView(coin: viewData)
    }
    
    func addToPortfolioButtonAction() {
        view?.showVC()
    }
}
