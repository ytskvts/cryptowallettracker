//
//  CoinListViewPresenterProtocol.swift
//  project
//
//  Created by Dzmitry on 13.02.22.
//

import Foundation

enum SearchBarButtonTapType {
    case cancel
    case search(String?)
}

protocol CoinsListViewPresenterProtocol {
    
    var viewData: [CoinTableViewCellViewModel] { get }
    
    func setDefaults()
    func refreshData(searchingText: String?)
    func prepareDetailVC(indexPath: IndexPath) -> DetailCoinViewController
    //MARK: - PickerView
    func getPickerViewTitle(for row: Int) -> String
    #warning("implement UILabel")
    func didSelectRowInPickerView(component: Int, row: Int, searchingText: String?)
    func getAmountOfPickerViewComponents() -> Int
    func getAmountOfPickerViewRows(in component: Int) -> Int
    
    
    //MARK: - SearchBar
    func searchBarButtonClicked(_ type: SearchBarButtonTapType)
    func searchBarShouldBeginEditing() -> Bool
    
    //MARK: - TableView
    //func prefetchRows(at indexPaths: [IndexPath])
    func didSelectRow(at indexPath: IndexPath)
    func willDisplay(forRowAt indexPath: IndexPath)
    
    func getNavigationTitle() -> String
    func getSearchBarPlaceholder() -> String
}
