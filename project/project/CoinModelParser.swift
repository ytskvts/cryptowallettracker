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
            
            do {
                let imageData = try Data(contentsOf: URL(string: $0.image)!)
                let image = UIImage(data: imageData)
                //print("vkusnp")
                return CoinTableViewCellViewModel(id: $0.id,
                                                  name: $0.name,
                                                  symbol: $0.symbol,
                                                  currentPrice: cutString(data: $0.current_price),
                                                  image: image ?? UIImage(systemName: "eye")!,
                                                  highDayPrice: $0.high_24h ?? 0,
                                                  lowDayPrice: $0.low_24h ?? 0,
                                                  priceChangeDay: Double(cutString(data: $0.price_change_24h ?? 0)) ?? 0,
                                                  priceChangePercentageDay: Double(cutString(data: $0.price_change_percentage_24h ?? 0)) ?? 0,
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
    
    func cutString(data: Double) -> String {
        var number = data
        var convertData: String
        if number.truncatingRemainder(dividingBy: 1) != 0 {
            number = Double(round(number * 1000) / 1000)
            convertData = String(format: "%.2f", number)
            for letter in String(convertData.reversed()) {
                if letter == "0" || letter == "." {
                    convertData.removeLast()
                } else {
                    break
                }
            }
        } else {
            convertData = "\(Int(number))"
        }
        return convertData
    }
}
