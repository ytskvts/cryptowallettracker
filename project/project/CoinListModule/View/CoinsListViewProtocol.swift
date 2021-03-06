//
//  CoinListViewProtocol.swift
//  project
//
//  Created by Dzmitry on 13.02.22.
//

import Foundation

protocol CoinsListViewProtocol: AnyObject {
    
    func showDetailVC(data: CoinTableViewCellViewModel)
    func tableViewReloadData()
    func setTitleForTypeOfSortLabel(name: String)
    func setupActivityIndicator()
    func stopActivityIndicator()
}
