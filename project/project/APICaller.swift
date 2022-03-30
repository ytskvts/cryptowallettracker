//
//  APICaller.swift
//  project
//
//  Created by Dzmitry on 6.12.21.
//

import Foundation

enum TypeOfSort: String {
    case marketCap = "market_cap_desc"
    case volume = "volume_desc"
    case popular = "gecko_desc"
    
    var name: String {
        switch self {
        case .marketCap:
            return "Market capitalization"
        case .volume:
            return "Volume"
        case .popular:
            return "Popular"
        }
    }
    init?(rawValue: String) {
        switch rawValue {
        case TypeOfSort.marketCap.name:
            self = .marketCap
        case TypeOfSort.volume.name:
            self = .volume
        case TypeOfSort.popular.name:
            self = .popular
        default:
            return nil
        }
    }
}

enum TypeOfRequest {
    case searchingRequest(searchingText: String, sortBy: TypeOfSort)
    case allCurrencies(sortBy: TypeOfSort, numberOfPage: Int)
    case favouriteCoins(IDs: [String])
}

struct SearchingCoin: Codable {
    let id: String
}
struct SearchingModel: Codable {
    let coins: [SearchingCoin]
}



final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    public func getAllCryptoData(numberOfPage: Int, completion: @escaping (Result<[CoinModel], Error>) -> Void) {
        guard let url = URL(string: requestUrlFirstPart + String(numberOfPage) + requestUrlLastPart) else {return}
        
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else {return}
            do {
                // decode responce
                let coins = try JSONDecoder().decode([CoinModel].self, from: data)
                completion(.success(coins))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    private func getIDs(getIDsURL: URL, completion: @escaping (Result<SearchingModel, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: getIDsURL) {data, _, error in
            guard let data = data, error == nil else {return}
            do {
                // decode responce
                print(data)
                let searchingModels = try JSONDecoder().decode(SearchingModel.self, from: data)
                completion(.success(searchingModels))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func buildURLString(requestType: TypeOfRequest) -> String {
        switch requestType {
        case .searchingRequest(let searchingText, let sortBy):
            guard let url = URL(string: "https://api.coingecko.com/api/v3/search?query=" + searchingText.lowercased()) else {return ""}
            var newModels = SearchingModel(coins: [])
            //kostyl vseh kostylei
            var joke = 1
            getIDs(getIDsURL: url) { result in
                switch result {
                case .success(let models):
                    newModels = models
                    joke += 1
                case .failure(let error):
                    print(error)
                    joke += 1
                }
            }
            while joke != 2 {
                continue
            }
            var requestString = ""
            if newModels.coins.count > 1 {
                for coin in newModels.coins {
                    requestString += "\(coin.id)%2C"
                }
                let index = requestString.index(requestString.endIndex, offsetBy: -3)
                requestString =  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=\(requestString[..<index])&order=\(sortBy.rawValue)&per_page=100&page=1&sparkline=true"
            } else {
                for coin in newModels.coins {
                    requestString += coin.id
                }
                requestString =  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=\(requestString)&order=\(sortBy.rawValue)&per_page=100&page=1&sparkline=true"
            }
            print("searching request url: \(requestString)")
            return requestString
            
        case .allCurrencies(let sortBy, let numberOfPage):
            print("all currencies request url: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=\(sortBy.rawValue)&per_page=20&page=\(numberOfPage)&sparkline=true")
            return "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=\(sortBy.rawValue)&per_page=20&page=\(numberOfPage)&sparkline=true"
        case .favouriteCoins(let IDs):
            var requestString = ""
            if IDs.count > 1 {
                for id in IDs {
                    requestString += "\(id)%2C"
                }
                let index = requestString.index(requestString.endIndex, offsetBy: -3)
                requestString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=\(requestString[..<index])&order=market_cap_desc&per_page=100&page=1&sparkline=false"
                
            } else {
                for id in IDs {
                    requestString += "\(id)"
                }
                requestString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=\(requestString)&order=market_cap_desc&per_page=100&page=1&sparkline=false"
                
            }
            print("favourite coins request url: \(requestString)")
            
            return requestString
        }
    }
    
    public func doRequest(requestType: TypeOfRequest, completion: @escaping (Result<[CoinModel], Error>) -> Void) {
        let urlString = buildURLString(requestType: requestType)
        
        guard let url = URL(string: urlString) else {return}
        //print("build url from urlString successfull")
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else {return}
            do {
                // decode responce
                let coins = try JSONDecoder().decode([CoinModel].self, from: data)
                completion(.success(coins))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
