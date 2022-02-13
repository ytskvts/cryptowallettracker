//
//  CoinListViewPresenter.swift
//  project
//
//  Created by Dzmitry on 12.02.22.
//

import Foundation

class CoinsListViewPresenter: CoinsListViewPresenterProtocol {
    
    weak var view: CoinsListViewProtocol?
    
    var chosenTypeOfSort: TypeOfSort = .marketCap {
        didSet {
            //обновить название лейбла сортирoвки
        }
    }
    
    var viewData: [CoinTableViewCellViewModel] = [] {
        didSet { view?.tableViewReloadData() }
    }
    
    let sortingNames: [String]
    init(sortingNames: [String] = AppConstants
            .CoinListScreenConstants
            .sortingNames) {
        
        self.sortingNames = sortingNames
    }
    func getPickerViewTitle(for row: Int) -> String {
        sortingNames[row]
    }
    
    func didSelectRowInPickerView(component: Int, row: Int) {
        chosenTypeOfSort = TypeOfSort(rawValue: sortingNames[row]) ?? .marketCap
    }
    
    func getAmountOfPickerViewComponents() -> Int {
        return 1
    }
    
    func getAmountOfPickerViewRows(in component: Int) -> Int {
        sortingNames.count
    }
    
    func searchBarButtonClicked(_ type: SearchBarButtonTapType) {
        switch type {
        case .search(let text):
            guard let text = text else { return }
            viewData = []
            

        case .cancel:
            
        }
    }
    
    func prefetchRows(at indexPaths: [IndexPath]) {
        
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        
    }
    
    func getNavigationTitle() -> String {
        return ""
    }
    
    func getSearchBarPlaceholder() -> String {
        return ""
    }
    
//    func updateViewData(with data: [CoinTableViewCellViewModel]) {
//        viewData = data
//        view?.tableViewReloadData()
//    }
//
    func getViewModels(sortingType: ,
                       numberOfPage: ,
                       callback: @escaping (([CoinTableViewCellViewModel]) -> Void)){
        APICaller.shared.
    }
}


