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
}

enum TypeOfRequest {
    case searchingRequest(searchingText: String, sortBy: TypeOfSort)
    case allCurrencies(sortBy: TypeOfSort, numberOfPage: Int)
    case favouriteCoins(IDs: [String])
}

struct SearchingModel: Decodable {
    let id: String
}

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    public func getAllCryptoData(numberOfPage: Int, completion: @escaping (Result<[Coin], Error>) -> Void) {
        guard let url = URL(string: requestUrlFirstPart + String(numberOfPage) + requestUrlLastPart) else {return}
        
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else {return}
            do {
                // decode responce
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(coins))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    private func getIDs(getIDsURL: URL, completion: @escaping (Result<[SearchingModel], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: getIDsURL) {data, _, error in
            guard let data = data, error == nil else {return}
            do {
                // decode responce
                let searchingModels = try JSONDecoder().decode([SearchingModel].self, from: data)
                completion(.success(searchingModels))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func buildURLString(requestType: TypeOfRequest) -> String {
        switch requestType {
        case .searchingRequest(let searchingText, let sortBy):
            guard let url = URL(string: "https://api.coingecko.com/api/v3/search?query=" + searchingText.lowercased()) else {return ""}
            var newModels = [SearchingModel]()
            getIDs(getIDsURL: url) { [weak self] result in
                switch result {
                case .success(let models):
                    newModels = models.compactMap({
                        return SearchingModel(id: $0.id)
                    })
                case .failure(let error):
                    print(error)
                }
            }
            var requestString = ""
            for model in newModels {
                requestString += "\(model.id)%2C"
            }
            let index = requestString.index(requestString.endIndex, offsetBy: -3)
            
            requestString =  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=\(requestString[..<index])&order=\(sortBy)&per_page=100&page=1&sparkline=false"
            return requestString
        case .allCurrencies(let sortBy, let numberOfPage):
            return "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=\(sortBy)&per_page=20&page=\(numberOfPage)&sparkline=false"
        case .favouriteCoins(let IDs):
            var requestString = ""
            for id in IDs {
                requestString += "\(id)%2C"
            }
            let index = requestString.index(requestString.endIndex, offsetBy: -3)
            requestString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=\(requestString[..<index])&order=market_cap_desc&per_page=100&page=1&sparkline=false"
            return requestString
        }
    }
}
