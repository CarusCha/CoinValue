//
//  CoinValueTests.swift
//  CoinValueTests
//
//  Created by carus on 27/4/2022.
//

import XCTest
@testable import CoinValue
@testable import RxSwift

class CoinValueTests: XCTestCase {
    
    func testPriceCalulationWithRateAndAmount() {
        let coin = Coin(time: "", asset_id_base: "", asset_id_quote: "", rate: 3.03)
        XCTAssertEqual(coin.getPrice(with: 0.11), 0.34)
        XCTAssertEqual(coin.getPrice(with: 0.12), 0.37)
        XCTAssertEqual(coin.getPrice(with: 0.13), 0.40)
        XCTAssertEqual(coin.getPrice(with: 0.14), 0.43)
        XCTAssertEqual(coin.getPrice(with: 0.15), 0.46)
        XCTAssertEqual(coin.getPrice(with: 0.16), 0.49)

    }
    
    func testRateFromServerIsNotNil() {
        let exp = expectation(description: "Get rate value from server")
        
        let coinOb = CoinService.fetchCoin(asset: "CRO")
        _ = coinOb.map({$0.rate})
            .subscribe(onNext: { rate in
                
                XCTAssertNotNil(rate, "Rate is nil")
                exp.fulfill()
                
            })
        
        waitForExpectations(timeout: 5.0)
    }

}
