//
//  ExchangeViewModel.swift
//  CoinValue
//
//  Created by carus on 28/4/2022.
//

import Foundation
import RxSwift
import RxCocoa

struct ExchangeViewModel {
    
    private var coin: Observable<Coin>
    var disposeBag = DisposeBag()
    var asset = PublishRelay<String>()
    var amount: BehaviorRelay<Double> = BehaviorRelay(value: 1000)
    var priceStr: BehaviorRelay<String> = BehaviorRelay(value: "0.00".toHKDStr())
    
    init(asset: String) {
        self.coin = CoinService.fetchCoin(asset: asset)
        bindInput()
    }
    
    func bindInput() {
        
        amount.subscribe(onNext: { amt in
            // bind coin price to priceStr relay
            _ = self.coin
                .map({$0.getPrice(with: amt)})
                .map({String($0).toHKDStr()})
                .catchAndReturn("0.00".toHKDStr())
                .bind(to: priceStr)
            
            // bind coin asset id to asset relay
            _ = self.coin
                .map({$0.asset_id_base})
                .catchAndReturn("")
                .bind(to: asset)
            
        }).disposed(by: disposeBag)

    }
    
}
