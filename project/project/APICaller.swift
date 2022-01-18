//
//  APICaller.swift
//  project
//
//  Created by Dzmitry on 6.12.21.
//

import Foundation

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
}
