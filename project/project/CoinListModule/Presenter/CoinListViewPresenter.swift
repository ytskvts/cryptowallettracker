//
//  CoinListViewPresenter.swift
//  project
//
//  Created by Dzmitry on 12.02.22.
//

import Foundation

enum SearchBarButtonType {
    case cancel
    case search
}

protocol CoinListViewPresenterType {
    
    
    
    var viewData: [CoinTableViewCellViewModel] { get }
    
    //MARK: - PickerView
    func getPickerViewTitle(for row: Int) -> String
    #warning("implement UILabel")
    func didSelectRowInPickerView(component: Int, row: Int)
    func getAmountOfPickerViewComponents() -> Int
    func getAmountOfPickerViewRows(in component: Int) -> Int
    
    
    //MARK: - SearchBar
    func searchBarButtonClicked(_ type: SearchBarButtonType)
    
    //MARK: - TableView
    func prefetchRows(at indexPaths: [IndexPath])
    func didSelectRow(at indexPath: IndexPath)
    
    func getNavigationTitle() -> String
    func getSearchBarPlaceholder() -> String
}



