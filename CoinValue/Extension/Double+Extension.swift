//
//  Double+Extension.swift
//  CoinValue
//
//  Created by carus on 1/5/2022.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded(.up) / divisor
    }
}
