//
//  WalletViewController.swift
//  project
//
//  Created by Dzmitry on 4.01.22.
//

import UIKit

class WalletViewController: UIViewController, WalletViewProtocol {
    
    var walletViewPresenter: WalletViewPresenterProtocol?
    

    
    private let bagImage: UIImageView = {
        let image = UIImage(systemName: "bag")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let totalCostLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let walletCoinsListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WalletTableViewCell.self, forCellReuseIdentifier: WalletTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        
        rc.attributedTitle = NSAttributedString(string: "Refresh table...", attributes: nil)
        return rc
    }()
    
    func setRefreshControl() {
        if #available(iOS 10.0, *) {
            walletCoinsListTableView.refreshControl = refreshControl
        } else {
            walletCoinsListTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
    }
    
    @objc func refreshControlAction() {
        walletViewPresenter?.getData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        walletViewPresenter = WalletViewPresenter(view: self)
        
        title = "Wallet"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        view.backgroundColor = .systemBlue
        walletCoinsListTableView.dataSource = self
        walletCoinsListTableView.delegate = self
        
        view.addSubview(walletCoinsListTableView)
        view.addSubview(bagImage)
        view.addSubview(totalCostLabel)
        view.addSubview(priceChangeLabel)
        setRefreshControl()
        
        createBagImageConstraint()
        createTotalCostLabelConstraint()
        createPriceChangeLabelConstraint()
        createWalletCoinsListTableViewConstraint()
        walletViewPresenter?.getData()
        
    }
    

    func configure(totalCost: String, priceChange: String, labelColor: ColorOfLabel) {
        DispatchQueue.main.async { [self] in
            totalCostLabel.text = totalCost + " $"
            
            if labelColor == .green {
                priceChangeLabel.textColor = .systemGreen
                priceChangeLabel.text = priceChange + " $"
            } else {
                priceChangeLabel.textColor = .systemRed
                priceChangeLabel.text = priceChange == "0.0" ? priceChange + " $" : "-" + priceChange + " $"
            }
            walletCoinsListTableView.reloadData()
            self.walletCoinsListTableView.refreshControl?.endRefreshing()
        }
        
    }
    
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.walletCoinsListTableView.reloadData()
            
        }
    }
    
    func createBagImageConstraint() {
        NSLayoutConstraint.activate([
            bagImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            bagImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            bagImage.widthAnchor.constraint(equalToConstant: 40),
            bagImage.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func createTotalCostLabelConstraint() {
        NSLayoutConstraint.activate([
            totalCostLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            totalCostLabel.leftAnchor.constraint(equalTo: bagImage.rightAnchor, constant: 10),
            totalCostLabel.widthAnchor.constraint(equalToConstant: 150),
            totalCostLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func createPriceChangeLabelConstraint() {
        NSLayoutConstraint.activate([
            priceChangeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            priceChangeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            priceChangeLabel.widthAnchor.constraint(equalToConstant: 140),
            priceChangeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func createWalletCoinsListTableViewConstraint() {
        NSLayoutConstraint.activate([
            walletCoinsListTableView.topAnchor.constraint(equalTo: bagImage.bottomAnchor, constant: 10),
            walletCoinsListTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            walletCoinsListTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            walletCoinsListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension WalletViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension WalletViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = walletViewPresenter else {return 10}
        return presenter.viewCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = walletCoinsListTableView.dequeueReusableCell(withIdentifier: WalletTableViewCell.identifier, for: indexPath) as? WalletTableViewCell,
              let presenter = walletViewPresenter else { fatalError() }
        cell.configure(with: presenter.viewCellData[indexPath.row])
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        walletViewPresenter?.deleteCoinFromPortfolio(index: indexPath)
    }
}
