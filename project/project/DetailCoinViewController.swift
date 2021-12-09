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
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        label.layer.cornerRadius = 3
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        label.layer.cornerRadius = 3
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
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangeDayPercentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lowPriceDayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.textColor = .systemRed
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let highPriceDayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.textColor = .systemGreen
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameDecribeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Name:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentPriceDecribeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Price:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let symbolDecribeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Shortname:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangeDayDecribeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Price change 24h:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangeDayPercentDecribeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Price change 24h:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lowPriceDayDecribeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Lowest price 24h:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let highPriceDayDecribeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Highest price 24h:"
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
        view.addSubview(nameDecribeLabel)
        view.addSubview(currentPriceDecribeLabel)
        view.addSubview(symbolDecribeLabel)
        view.addSubview(priceChangeDayDecribeLabel)
        view.addSubview(priceChangeDayPercentDecribeLabel)
        view.addSubview(lowPriceDayDecribeLabel)
        view.addSubview(highPriceDayDecribeLabel)
        
        createCoinImageViewConstraint()
        createNameLabelConstraint()
        createSymbolLabelConstraint()
        createCurrentPriceLabelConstraint()
        createPriceChangeDayLabelConstraint()
        createPriceChangeDayPercentLabelConstraint()
        createLowPriceDayLabelConstraint()
        createHighPriceDayLabelConstraint()
        createNameDecribeLabelConstraint()
        createSymbolDecribeLabelConstraint()
        createCurrentPriceDecribeLabelConstraint()
        createPriceChangeDayDecribeLabelConstraint()
        createPriceChangeDayPercentDecribeLabelConstraint()
        createLowPriceDayDecribeLabelConstraint()
        createHighPriceDayDecribeLabelConstraint()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Constraints
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
            nameLabel.topAnchor.constraint(equalTo: coinImageView.bottomAnchor, constant: 40),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createSymbolLabelConstraint() {
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            symbolLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            symbolLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            symbolLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor)
        ])
    }
    
    func createCurrentPriceLabelConstraint() {
        NSLayoutConstraint.activate([
            currentPriceLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 30),
            currentPriceLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            currentPriceLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            currentPriceLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor)
        ])
    }
    
    func createPriceChangeDayLabelConstraint() {
        NSLayoutConstraint.activate([
            priceChangeDayLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 30),
            priceChangeDayLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            priceChangeDayLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            priceChangeDayLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor)
        ])
    }
    
    func createPriceChangeDayPercentLabelConstraint() {
        NSLayoutConstraint.activate([
            priceChangeDayPercentLabel.topAnchor.constraint(equalTo: priceChangeDayLabel.bottomAnchor, constant: 30),
            priceChangeDayPercentLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            priceChangeDayPercentLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            priceChangeDayPercentLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor)
        ])
    }
    
    func createLowPriceDayLabelConstraint() {
        NSLayoutConstraint.activate([
            lowPriceDayLabel.topAnchor.constraint(equalTo: highPriceDayLabel.bottomAnchor, constant: 30),
            lowPriceDayLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            lowPriceDayLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            lowPriceDayLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor)
        ])
    }
    
    func createHighPriceDayLabelConstraint() {
        NSLayoutConstraint.activate([
            highPriceDayLabel.topAnchor.constraint(equalTo: priceChangeDayPercentLabel.bottomAnchor, constant: 30),
            highPriceDayLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            highPriceDayLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            highPriceDayLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor)
        ])
    }
    
    func createNameDecribeLabelConstraint() {
        NSLayoutConstraint.activate([
            nameDecribeLabel.topAnchor.constraint(equalTo: coinImageView.bottomAnchor, constant: 40),
            nameDecribeLabel.widthAnchor.constraint(equalToConstant: 200),
            nameDecribeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            nameDecribeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createSymbolDecribeLabelConstraint() {
        NSLayoutConstraint.activate([
            symbolDecribeLabel.topAnchor.constraint(equalTo: nameDecribeLabel.bottomAnchor, constant: 30),
            symbolDecribeLabel.widthAnchor.constraint(equalTo: nameDecribeLabel.widthAnchor),
            symbolDecribeLabel.leftAnchor.constraint(equalTo: nameDecribeLabel.leftAnchor),
            symbolDecribeLabel.heightAnchor.constraint(equalTo: nameDecribeLabel.heightAnchor)
        ])
    }
    
    func createCurrentPriceDecribeLabelConstraint() {
        NSLayoutConstraint.activate([
            currentPriceDecribeLabel.topAnchor.constraint(equalTo: symbolDecribeLabel.bottomAnchor, constant: 30),
            currentPriceDecribeLabel.widthAnchor.constraint(equalTo: nameDecribeLabel.widthAnchor),
            currentPriceDecribeLabel.leftAnchor.constraint(equalTo: nameDecribeLabel.leftAnchor),
            currentPriceDecribeLabel.heightAnchor.constraint(equalTo: nameDecribeLabel.heightAnchor)
        ])
    }
    
    func createPriceChangeDayDecribeLabelConstraint() {
        NSLayoutConstraint.activate([
            priceChangeDayDecribeLabel.topAnchor.constraint(equalTo: currentPriceDecribeLabel.bottomAnchor, constant: 30),
            priceChangeDayDecribeLabel.widthAnchor.constraint(equalTo: nameDecribeLabel.widthAnchor),
            priceChangeDayDecribeLabel.leftAnchor.constraint(equalTo: nameDecribeLabel.leftAnchor),
            priceChangeDayDecribeLabel.heightAnchor.constraint(equalTo: nameDecribeLabel.heightAnchor)
        ])
    }
    
    func createPriceChangeDayPercentDecribeLabelConstraint() {
        NSLayoutConstraint.activate([
            priceChangeDayPercentDecribeLabel.topAnchor.constraint(equalTo: priceChangeDayDecribeLabel.bottomAnchor, constant: 30),
            priceChangeDayPercentDecribeLabel.widthAnchor.constraint(equalTo: nameDecribeLabel.widthAnchor),
            priceChangeDayPercentDecribeLabel.leftAnchor.constraint(equalTo: nameDecribeLabel.leftAnchor),
            priceChangeDayPercentDecribeLabel.heightAnchor.constraint(equalTo: nameDecribeLabel.heightAnchor)
        ])
    }
    
    func createLowPriceDayDecribeLabelConstraint() {
        NSLayoutConstraint.activate([
            lowPriceDayDecribeLabel.topAnchor.constraint(equalTo: highPriceDayDecribeLabel.bottomAnchor, constant: 30),
            lowPriceDayDecribeLabel.widthAnchor.constraint(equalTo: nameDecribeLabel.widthAnchor),
            lowPriceDayDecribeLabel.leftAnchor.constraint(equalTo: nameDecribeLabel.leftAnchor),
            lowPriceDayDecribeLabel.heightAnchor.constraint(equalTo: nameDecribeLabel.heightAnchor)
        ])
    }
    
    func createHighPriceDayDecribeLabelConstraint() {
        NSLayoutConstraint.activate([
            highPriceDayDecribeLabel.topAnchor.constraint(equalTo: priceChangeDayPercentDecribeLabel.bottomAnchor, constant: 30),
            highPriceDayDecribeLabel.widthAnchor.constraint(equalTo: nameDecribeLabel.widthAnchor),
            highPriceDayDecribeLabel.leftAnchor.constraint(equalTo: nameDecribeLabel.leftAnchor),
            highPriceDayDecribeLabel.heightAnchor.constraint(equalTo: nameDecribeLabel.heightAnchor)
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
}
