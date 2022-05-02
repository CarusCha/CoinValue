//
//  CoinService.swift
//  CoinValue
//
//  Created by carus on 1/5/2022.
//

import Foundation
import RxSwift

struct CoinService {

    private static let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    private static let apiKey = "API_KEY"

    private static func parseJSON(_ data: Data?) throws -> Coin {
        return try JSONDecoder().decode(Coin.self, from: data ?? Data())
    }
    
    // Fetch the coin data from the coin api
    static func fetchCoin(asset: String) -> Observable<Coin> {
//        return Observable.just(Coin(time: "", asset_id_base: "", asset_id_quote: "", rate: 3.0))
        
        
        return Observable.create { emitter -> Disposable in
            let urlString = "\(baseURL)/\(asset)/HKD"

            guard let url = URL(string: "\(urlString)?apikey=\(apiKey)") else { return Disposables.create{} }

            // Session
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    emitter.onError(error)
                    return
                }

                do {
                    let coin = try parseJSON(data)
                    emitter.onNext(coin)
                } catch {
                    let err = NSError(domain: "Parsing Error", code: 1, userInfo: nil)
                    emitter.onError(err)
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
