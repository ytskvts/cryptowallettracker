//
//  FirebaseModel.swift
//  project
//
//  Created by Dzmitry on 3.03.22.
//

import Foundation

struct Coin: Codable, Hashable {
    var id: String
    var price: String
    var quantity: String
}

struct Portfolio: Codable {
    var coins: [Coin]
}
