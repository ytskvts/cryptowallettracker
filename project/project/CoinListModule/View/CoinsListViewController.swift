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
    private var chosenTypeOfSort = TypeOfSort.marketCap
    
    let namesOfSort = ["Market capitalization", "Volume", "Popular"]

    
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    
//    private var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else {return false}
//        return text.isEmpty
//    }
    
//    private var isSearching : Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
    
    private var isSearching: Bool = false
    
    private let describeTypeOfSortLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort by:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeOfSortTextField: UITextField = {
        let textField = TypeOfSortTextField()
        textField.text = "Market capitalization"
        textField.addTarget(self, action: #selector(CoinsListViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImageView(image: UIImage(systemName: "chevron.down"))
//        let rightView = UIView()
//        rightView.addSubview(image!)
        textField.rightView = image
        textField.rightViewMode = .always
        return textField
    }()
    
    var typeOfSortPicker: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
    }()
    
    private let coinsListTableView: UITableView = {
        let tableView = UITableView()
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
//        view.addSubview(describeTypeOfSortLabel)
//        view.addSubview(typeOfSortTextField)
        coinsListTableView.dataSource = self
        coinsListTableView.delegate = self
        coinsListTableView.prefetchDataSource = self
        typeOfSortPicker.delegate = self
        typeOfSortPicker.dataSource = self
        typeOfSortTextField.text = namesOfSort[0]
        typeOfSortTextField.inputView = typeOfSortPicker
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: coinsListTableView.frame.width,
                                              height: 25))
        coinsListTableView.tableHeaderView = headerView
        headerView.addSubview(describeTypeOfSortLabel)
        headerView.addSubview(typeOfSortTextField)
       
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
        createDescribeTypeOfSortLabelConstraint()
        createTypeOfSortTextFieldConstraint()
        //createCoinsListTableViewConstraint()
    }
    

    
    func createDescribeTypeOfSortLabelConstraint() {
        NSLayoutConstraint.activate([
            describeTypeOfSortLabel.topAnchor.constraint(equalTo: coinsListTableView.topAnchor, constant: 5),
            describeTypeOfSortLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            describeTypeOfSortLabel.widthAnchor.constraint(equalToConstant: 70),
            describeTypeOfSortLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func createTypeOfSortTextFieldConstraint() {
        NSLayoutConstraint.activate([
            typeOfSortTextField.topAnchor.constraint(equalTo: describeTypeOfSortLabel.topAnchor),
            typeOfSortTextField.leftAnchor.constraint(equalTo: describeTypeOfSortLabel.rightAnchor, constant: 5),
            typeOfSortTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            typeOfSortTextField.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
//    func createCoinsListTableViewConstraint() {
//        NSLayoutConstraint.activate([
//            coinsListTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
//            coinsListTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            coinsListTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            coinsListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("fuck")
        guard let text = textField.text,
              let sortingType = TypeOfSort(rawValue: text) else {
                  return }
        chosenTypeOfSort = sortingType
        if isSearching {
            
        } else {
            numberOfPage = 1
            self.usualViewModels = []
            getCurrencies()
        }
        print("fwefgwe")
    }
 
    
    @objc func getCurrencies() {
        let requestType = TypeOfRequest.allCurrencies(sortBy: chosenTypeOfSort, numberOfPage: numberOfPage)
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
        typeOfSortTextField.resignFirstResponder()
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
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 25
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView(frame: CGRect(x: 0,
//                                                  y: 0,
//                                                  width: tableView.frame.width,
//                                                  height: 25))
//        headerView.addSubview(describeTypeOfSortLabel)
//        NSLayoutConstraint.activate([
//            describeTypeOfSortLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
//            describeTypeOfSortLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 10),
//            describeTypeOfSortLabel.widthAnchor.constraint(equalToConstant: 70),
//            describeTypeOfSortLabel.heightAnchor.constraint(equalToConstant: 20)
//        ])
//        headerView.addSubview(typeOfSortTextField)
//        NSLayoutConstraint.activate([
//            typeOfSortTextField.topAnchor.constraint(equalTo: describeTypeOfSortLabel.topAnchor),
//            typeOfSortTextField.leftAnchor.constraint(equalTo: describeTypeOfSortLabel.rightAnchor, constant: 5),
//            typeOfSortTextField.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -10),
//            typeOfSortTextField.heightAnchor.constraint(equalToConstant: 20)
//        ])
//        return headerView
//    }
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
        cell.selectionStyle = .none
        return cell
        
    }
}

extension CoinsListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
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
        let requestType = TypeOfRequest.searchingRequest(searchingText: searchText, sortBy: chosenTypeOfSort)
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

extension CoinsListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return namesOfSort.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return namesOfSort[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //typeOfSortTextField.text = namesOfSort[row]
        typeOfSortTextField.text = ""
        typeOfSortTextField.insertText(namesOfSort[row])
        typeOfSortTextField.resignFirstResponder()
        
    }
    
}
