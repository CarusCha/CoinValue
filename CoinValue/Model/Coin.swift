//
//  Coin.swift
//  CoinValue
//
//  Created by carus on 27/4/2022.
//

import Foundation

// MARK: - Coin
struct Coin: Decodable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
    
    // Calculate price with the input amount
    func getPrice(with amount: Double) -> Double {
        let price = rate * amount
        return price.rounded(toPlaces: 2)
    }
}
