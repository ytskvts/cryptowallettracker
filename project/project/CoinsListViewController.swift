//
//  CoinsListViewController.swift
//  project
//
//  Created by Dzmitry on 6.12.21.
//

import UIKit
import SwiftUI

class CoinsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    private let coinsListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.identifier)
        return tableView
    }()
    
    
    private var viewModels = [CoinTableViewCellViewModel]()
    
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
        title = "CoinList"
        view.addSubview(coinsListTableView)
        coinsListTableView.dataSource = self
        coinsListTableView.delegate = self
        getCurrencies()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        coinsListTableView.frame = view.bounds
    }
    

    @objc func getCurrencies() {
        APICaller.shared.getAllCryptoData { [weak self] result in
            switch result {
            case .success(let models):
                print(models.count)
                self?.viewModels = models.compactMap({
                    //Numberformatter
                    var currentPrice = $0.current_price
                    var convertPrice: String
                    if currentPrice.truncatingRemainder(dividingBy: 1) != 0 {
                        currentPrice = Double(round(currentPrice * 1000) / 1000)
                        convertPrice = String(format: "%.2f", currentPrice)
                    } else {
                        convertPrice = "\(Int(currentPrice))"
                    }
                    print(type(of: $0.current_price))
                    print(type(of: $0.image))
                    let imageData = try! Data(contentsOf: URL(string: $0.image)!)
                    let image = UIImage(data: imageData)
                    return CoinTableViewCellViewModel(name: $0.name, symbol: $0.symbol, currentPrice: convertPrice + " $", image: (image ?? UIImage(systemName: "eye"))!, highDayPrice: $0.high_24h, lowDayPrice: $0.low_24h, priceChangeDay: $0.price_change_24h, priceChangePercentageDay: $0.price_change_percentage_24h)
                    
                })
                DispatchQueue.main.async {
                    self?.coinsListTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showDetailVC(indexPath: IndexPath) {
//        if let navigationcontroller = navigationController {
//            let detailVC = DetailCoinViewController()
//            detailVC.configure(with: viewModels[indexPath.row])
//            navigationcontroller.pushViewController(detailVC, animated: true)
//
//
//        }
        let detailVC = DetailCoinViewController()
        detailVC.configure(with: viewModels[indexPath.row])
        present(detailVC, animated: true, completion: nil)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = coinsListTableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath) as? CoinTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailVC(indexPath: indexPath)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
