//
//  CoinModelParser.swift
//  project
//
//  Created by Dzmitry on 13.02.22.
//

import UIKit

struct CoinModelParser {
    
    func parseToViewModels(models: [CoinModel]) -> [CoinTableViewCellViewModel] {
        models.compactMap({
            // use Numberformatter instead of this
            var currentPrice = $0.current_price
            var convertPrice: String
            if currentPrice.truncatingRemainder(dividingBy: 1) != 0 {
                currentPrice = Double(round(currentPrice * 1000) / 1000)
                convertPrice = String(format: "%.2f", currentPrice)
                for letter in String(convertPrice.reversed()) {
                    if letter == "0" || letter == "." {
                        convertPrice.removeLast()
                    } else {
                        break
                    }
                }
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
                                                  priceChangePercentageDay: $0.price_change_percentage_24h ?? 0,
                                                  lastUpdated: $0.lastUpdated ?? nil,
                                                  sparklineIn7D: $0.sparkline_in_7d ?? nil,
                                                  ath: $0.ath,
                                                  atl: $0.atl)
            } catch {
                print(error)
                return nil
            }
        })
    }
}
