//
//  DetailCoinViewController.swift
//  project
//
//  Created by Dzmitry on 7.12.21.
//

import UIKit

class DetailCoinViewController: UIViewController {
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coinImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let priceChangeDayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangeDayPercentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lowPriceDayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let highPriceDayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(nameLabel)
        view.addSubview(currentPriceLabel)
        view.addSubview(symbolLabel)
        view.addSubview(coinImageView)
        view.addSubview(priceChangeDayLabel)
        view.addSubview(priceChangeDayPercentLabel)
        view.addSubview(lowPriceDayLabel)
        view.addSubview(highPriceDayLabel)
        createCoinImageViewConstraint()
        createNameLabelConstraint()
        createSymbolLabelConstraint()
        createCurrentPriceLabelConstraint()
        createPriceChangeDayLabelConstraint()
        createPriceChangeDayPercentLabelConstraint()
        createLowPriceDayLabelConstraint()
        createHighPriceDayLabelConstraint()
        // Do any additional setup after loading the view.
    }
    

    
    
    func createCoinImageViewConstraint() {
        NSLayoutConstraint.activate([
            coinImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            coinImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinImageView.widthAnchor.constraint(equalToConstant: 200),
            coinImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func createNameLabelConstraint() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: coinImageView.bottomAnchor, constant: 20),
            nameLabel.leftAnchor.constraint(equalTo: coinImageView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: coinImageView.rightAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func createSymbolLabelConstraint() {
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            symbolLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            symbolLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            symbolLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createCurrentPriceLabelConstraint() {
        NSLayoutConstraint.activate([
            currentPriceLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 20),
            currentPriceLabel.leftAnchor.constraint(equalTo: symbolLabel.leftAnchor),
            currentPriceLabel.rightAnchor.constraint(equalTo: symbolLabel.rightAnchor),
            currentPriceLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func createPriceChangeDayLabelConstraint() {
        NSLayoutConstraint.activate([
            priceChangeDayLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 20),
            priceChangeDayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            priceChangeDayLabel.heightAnchor.constraint(equalToConstant: 20),
            priceChangeDayLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func createPriceChangeDayPercentLabelConstraint() {
        NSLayoutConstraint.activate([
            priceChangeDayPercentLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 20),
            priceChangeDayPercentLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            priceChangeDayPercentLabel.heightAnchor.constraint(equalToConstant: 20),
            priceChangeDayPercentLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func createLowPriceDayLabelConstraint() {
        NSLayoutConstraint.activate([
            lowPriceDayLabel.topAnchor.constraint(equalTo: priceChangeDayLabel.topAnchor, constant: 20),
            lowPriceDayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            lowPriceDayLabel.heightAnchor.constraint(equalToConstant: 20),
            lowPriceDayLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func createHighPriceDayLabelConstraint() {
        NSLayoutConstraint.activate([
            highPriceDayLabel.topAnchor.constraint(equalTo: priceChangeDayPercentLabel.topAnchor, constant: 20),
            highPriceDayLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            highPriceDayLabel.heightAnchor.constraint(equalToConstant: 20),
            highPriceDayLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configure(with viewModel: CoinTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        symbolLabel.text = viewModel.symbol
        currentPriceLabel.text = viewModel.currentPrice
        coinImageView.image = viewModel.image
        if viewModel.priceChangeDay > 0 {
            priceChangeDayLabel.textColor = .systemGreen
            priceChangeDayPercentLabel.textColor = .systemGreen
        } else {
            priceChangeDayLabel.textColor = .systemRed
            priceChangeDayPercentLabel.textColor = .systemRed
        }
        priceChangeDayLabel.text = "\(viewModel.priceChangeDay) $"
        priceChangeDayPercentLabel.text = "\(viewModel.priceChangePercentageDay) %"
        lowPriceDayLabel.text = "\(viewModel.lowDayPrice) $"
        highPriceDayLabel.text = "\(viewModel.highDayPrice) $"
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
