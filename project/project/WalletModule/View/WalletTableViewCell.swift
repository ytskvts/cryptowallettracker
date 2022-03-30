//
//  WalletTableViewCell.swift
//  project
//
//  Created by Dzmitry on 1.03.22.
//

import UIKit

struct WalletTableViewCellModel{
    let image: UIImage
    let symbol: String
    let quantity: Double
    let totalCoinPrice: Double
}

class WalletTableViewCell: UITableViewCell {
    
    static let identifier = "WalletTableViewCell"
    
    private let coinImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let coinSymbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalCoinPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let quantityOfCoinLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.addSubview(coinImageView)
        contentView.addSubview(coinSymbolLabel)
        contentView.addSubview(quantityOfCoinLabel)
        contentView.addSubview(totalCoinPriceLabel)
        
        createCoinImageViewConstraint()
        createCoinSymbolLabelConstraint()
        createQuantityOfCoinLabelConstraint()
        createTotalCoinPriceLabelConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func configure(with model: WalletTableViewCellModel) {
        coinSymbolLabel.text = model.symbol
        quantityOfCoinLabel.text = "\(model.quantity)"
        totalCoinPriceLabel.text = "\(model.totalCoinPrice) $"
        coinImageView.image = model.image
    }
    
    func createCoinImageViewConstraint() {
        NSLayoutConstraint.activate([
            coinImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            coinImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            coinImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            coinImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createCoinSymbolLabelConstraint() {
        NSLayoutConstraint.activate([
            coinSymbolLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            coinSymbolLabel.leftAnchor.constraint(equalTo: coinImageView.rightAnchor, constant: 10),
            coinSymbolLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            coinSymbolLabel.widthAnchor.constraint(equalToConstant: 70) //30 height
        ])
    }
    
    func createQuantityOfCoinLabelConstraint() {
        NSLayoutConstraint.activate([
            quantityOfCoinLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            quantityOfCoinLabel.leftAnchor.constraint(equalTo: coinSymbolLabel.rightAnchor, constant: 30),
            quantityOfCoinLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            quantityOfCoinLabel.widthAnchor.constraint(equalToConstant: 70) //20 height
        ])
    }
    
    func createTotalCoinPriceLabelConstraint() {
        NSLayoutConstraint.activate([
            totalCoinPriceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            totalCoinPriceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            totalCoinPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            totalCoinPriceLabel.leftAnchor.constraint(equalTo: quantityOfCoinLabel.rightAnchor, constant: 10) //40 height
        ])
    }

}
