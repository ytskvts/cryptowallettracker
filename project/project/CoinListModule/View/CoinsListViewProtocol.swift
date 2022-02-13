//
//  CoinListViewProtocol.swift
//  project
//
//  Created by Dzmitry on 13.02.22.
//

import Foundation

protocol CoinsListViewProtocol: AnyObject {
    
    func showDetailVC(indexPath: IndexPath)
    func tableViewReloadData()
}
