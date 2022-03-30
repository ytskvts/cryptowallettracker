//
//  FirebaseManager.swift
//  project
//
//  Created by Dzmitry on 3.03.22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseCore



class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private func configureFB() -> Firestore {
        var db: Firestore
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    

    
    func getPortfolio(completion: @escaping (Portfolio?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = configureFB()
        db.collection("users").document(userId).getDocument(completion: { (document, error) in
            guard error == nil else {completion(nil); return}
            if let document = document {
                var portfolio = Portfolio(coins: [])
                let coinsArray = document["coins"] as? Array ?? []
                for coin in coinsArray {
                    //print(type(of: coin))
                    let dictOfCoin = coin as? Dictionary ?? [:]
                    guard let id = dictOfCoin["id"] as? String,
                          let price = dictOfCoin["price"] as? String,
                          let quantity = dictOfCoin["quantity"] as? String else {completion(nil); return}
                    portfolio.coins.append(Coin(id: id, price: price, quantity: quantity))
                }
                completion(portfolio)
            }
        })
    }
    
    func add(coinForAdding: Coin) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = configureFB()
        getPortfolio { portfolio in
            guard var portfolio = portfolio else {return}
            var isCoinExist = false
            if portfolio.coins.count >= 1 {
                for i in 0...portfolio.coins.count - 1 {
                    if portfolio.coins[i].id == coinForAdding.id {
                        let coinPrice = Double(portfolio.coins[i].price) ?? 0.0
                        let coinQuantity = Double(portfolio.coins[i].quantity) ?? 0.0
                        let coinForAddingPrice = Double(coinForAdding.price) ?? 0.0
                        let coinForAddingQuantity = Double(coinForAdding.quantity) ?? 0.0
                        let resultQuantity = coinQuantity + coinForAddingQuantity
                        let resultPrice = (coinPrice * coinQuantity + coinForAddingPrice * coinForAddingQuantity) / resultQuantity
                        portfolio.coins[i].price = "\(resultPrice)"
                        portfolio.coins[i].quantity = "\(resultQuantity)"
                        isCoinExist = true
                        break
                    }
                }
            }
            
            if !isCoinExist {
                portfolio.coins.append(coinForAdding)
            }
            var dataForSending = [Dictionary<String, String>]()
            for coin in portfolio.coins {
                let dict = ["id" : coin.id,
                            "price" : coin.price,
                            "quantity" : coin.quantity]
                dataForSending.append(dict)
            }
            db.collection("users").document(userId).setData(["coins" : dataForSending])
        }
    }
    
    func delete(id: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = configureFB()
        getPortfolio { portfolio in
            guard var portfolio = portfolio else {return}
            for i in 0...portfolio.coins.count - 1 {
                if portfolio.coins[i].id == id {
                    portfolio.coins.remove(at: i)
                    var dataForSending = [Dictionary<String, String>]()
                    for coin in portfolio.coins {
                        let dict = ["id" : coin.id,
                                    "price" : coin.price,
                                    "quantity" : coin.quantity]
                        dataForSending.append(dict)
                    }
                    db.collection("users").document(userId).setData(["coins" : dataForSending])
                    break
                }
            }
            
        }
    }
    
    
    func createUserDocumentAndCoinsArrayInDB() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        print(Auth.auth().currentUser?.uid ?? "can't print uiid")
        let db = configureFB()
        let usersRef = db.collection("users")
        usersRef.document(userId).setData(["coins" : [] ])
    }
    
    
}

extension DocumentReference {
    func set() { setData([:]) }
}
