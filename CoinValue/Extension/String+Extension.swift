//
//  String+Extension.swift
//  CoinValue
//
//  Created by carus on 2/5/2022.
//

import Foundation

extension String {
    func toHKDStr() -> String {
        return "$\(self) HKD"
    }
}
