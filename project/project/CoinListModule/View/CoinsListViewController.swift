//
//  CoinsListViewController.swift
//  project
//
//  Created by Dzmitry on 6.12.21.
//

import UIKit

class CoinsListViewController: UIViewController {
 
    //MARK: just for minimum viable product
    private var usualViewModels = [CoinTableViewCellViewModel]()
    private var searchingModeViewModels = [CoinTableViewCellViewModel]()
    private var numberOfPage: Int = 1
    
    private let searchController = UISearchController(searchResultsController: nil)
    
//    private var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else {return false}
//        return text.isEmpty
//    }
    
//    private var isSearching : Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
    
    private var isSearching: Bool = false
    
    private let coinsListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: do it later
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coins"
        view.addSubview(coinsListTableView)
        coinsListTableView.dataSource = self
        coinsListTableView.delegate = self
        coinsListTableView.prefetchDataSource = self
        //searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
       
        getCurrencies()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        coinsListTableView.frame = view.bounds
    }
    
    
 
    
    @objc func getCurrencies() {
        let requestType = TypeOfRequest.allCurrencies(sortBy: .marketCap, numberOfPage: numberOfPage)
        APICaller.shared.doRequest(requestType: requestType) { [weak self] result in
            switch result {
            case .success(let models):
                var newModels = [CoinTableViewCellViewModel]()
                newModels = models.compactMap({
                    // use Numberformatter instead of this
                    var currentPrice = $0.current_price
                    var convertPrice: String
                    if currentPrice.truncatingRemainder(dividingBy: 1) != 0 {
                        currentPrice = Double(round(currentPrice * 1000) / 1000)
                        convertPrice = String(format: "%.2f", currentPrice)
                    } else {
                        convertPrice = "\(Int(currentPrice))"
                    }
                    do {
                        let imageData = try Data(contentsOf: URL(string: $0.image)!)
                        let image = UIImage(data: imageData)
                        return CoinTableViewCellViewModel(name: $0.name,
                                                          symbol: $0.symbol,
                                                          currentPrice: convertPrice + " $",
                                                          image: image ?? UIImage(systemName: "eye")!,
                                                          highDayPrice: $0.high_24h ?? 0,
                                                          lowDayPrice: $0.low_24h ?? 0,
                                                          priceChangeDay: $0.price_change_24h ?? 0,
                                                          priceChangePercentageDay: $0.price_change_percentage_24h ?? 0)
                    } catch {
                        print(error)
                        return nil
                    }
                })
                self?.usualViewModels.append(contentsOf: newModels)
                DispatchQueue.main.async {
                    self?.coinsListTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
//        APICaller.shared.getAllCryptoData(numberOfPage: numberOfPage) { [weak self] result in
//            switch result {
//            case .success(let models):
//                var newModels = [CoinTableViewCellViewModel]()
//                newModels = models.compactMap({
//                    // use Numberformatter instead of this
//                    var currentPrice = $0.current_price
//                    var convertPrice: String
//                    if currentPrice.truncatingRemainder(dividingBy: 1) != 0 {
//                        currentPrice = Double(round(currentPrice * 1000) / 1000)
//                        convertPrice = String(format: "%.2f", currentPrice)
//                    } else {
//                        convertPrice = "\(Int(currentPrice))"
//                    }
//                    do {
//                        let imageData = try Data(contentsOf: URL(string: $0.image)!)
//                        let image = UIImage(data: imageData)
//                        return CoinTableViewCellViewModel(name: $0.name,
//                                                          symbol: $0.symbol,
//                                                          currentPrice: convertPrice + " $",
//                                                          image: image ?? UIImage(systemName: "eye")!,
//                                                          highDayPrice: $0.high_24h,
//                                                          lowDayPrice: $0.low_24h,
//                                                          priceChangeDay: $0.price_change_24h,
//                                                          priceChangePercentageDay: $0.price_change_percentage_24h)
//                    } catch {
//                        print(error)
//                        return nil
//                    }
//                })
//                self?.viewModels.append(contentsOf: newModels)
//                DispatchQueue.main.async {
//                    self?.coinsListTableView.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    func showDetailVC(indexPath: IndexPath) {
        let detailVC = DetailCoinViewController()
        print("showDetailVC")
        if isSearching {
            detailVC.configure(with: searchingModeViewModels[indexPath.row])
        } else {
            detailVC.configure(with: usualViewModels[indexPath.row])
        }
        
        present(detailVC, animated: true, completion: nil)
    }
}












extension CoinsListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailVC(indexPath: indexPath)
    }
}

extension CoinsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchingModeViewModels.count
        }
        return usualViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = coinsListTableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath) as? CoinTableViewCell else {
            fatalError()
        }
        if isSearching {
            cell.configure(with: searchingModeViewModels[indexPath.row])
        } else {
            cell.configure(with: usualViewModels[indexPath.row])
        }
        return cell
        
    }
}

extension CoinsListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(numberOfPage)
        if !isSearching {
            if numberOfPage < 58 {
                numberOfPage += 1
                getCurrencies()
            }
        }


    }


}

//extension CoinsListViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        print("t")
//    }
//
//
//}

extension CoinsListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = true
        self.searchingModeViewModels = []
        guard let searchText = searchBar.text else {return}
        let requestType = TypeOfRequest.searchingRequest(searchingText: searchText, sortBy: .marketCap)
        APICaller.shared.doRequest(requestType: requestType) { [weak self] result in
            switch result {
            case .success(let models):
                var newModels = [CoinTableViewCellViewModel]()
                newModels = models.compactMap({
                    // use Numberformatter instead of this
                    var currentPrice = $0.current_price
                    var convertPrice: String
                    if currentPrice.truncatingRemainder(dividingBy: 1) != 0 {
                        currentPrice = Double(round(currentPrice * 1000) / 1000)
                        convertPrice = String(format: "%.2f", currentPrice)
                    } else {
                        convertPrice = "\(Int(currentPrice))"
                    }
                    do {
                        let imageData = try Data(contentsOf: URL(string: $0.image)!)
                        let image = UIImage(data: imageData)
                        print("vkusnp")
                        return CoinTableViewCellViewModel(name: $0.name,
                                                          symbol: $0.symbol,
                                                          currentPrice: convertPrice + " $",
                                                          image: image ?? UIImage(systemName: "eye")!,
                                                          highDayPrice: $0.high_24h ?? 0,
                                                          lowDayPrice: $0.low_24h ?? 0,
                                                          priceChangeDay: $0.price_change_24h ?? 0,
                                                          priceChangePercentageDay: $0.price_change_percentage_24h ?? 0)
                    } catch {
                        print(error)
                        print("eh")
                        return nil
                    }
                })
                self?.searchingModeViewModels.append(contentsOf: newModels)
                //print(self?.searchingModeViewModels)
                DispatchQueue.main.async {
                    self?.coinsListTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchingModeViewModels = []
        coinsListTableView.reloadData()
    }
    
  
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        //isSearching = true
//
//    }
}
