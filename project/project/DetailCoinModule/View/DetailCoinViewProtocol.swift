//
//  DetailCoinViewProtocol.swift
//  project
//
//  Created by Dzmitry on 23.02.22.
//

import Foundation

protocol DetailCoinViewProtocol: AnyObject {
    
    //var detailCoinView: DetailCoinView {get set}
    //func setupView(detailCoinView: DetailCoinView)
    func setupFields(viewData: CoinTableViewCellViewModel)
}
