//
//  CoinManager.swift
//  BitcoinExchange
//
//  Created by Willy Sato on 2022/08/22.
//

import Foundation

protocol CoinManagerDelegate: AnyObject {
    func updateCoin(currency: String)
}

class CoinManager {
    var delegate: CoinManagerDelegate?
    
    let apiUrl = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "B5E143B0-0ACD-4922-BC06-4EC2F94A3658"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func fechData(with currency: String) {
        let urlString = "\(apiUrl)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                guard error == nil else {
                    return
                }
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let safeData = try decoder.decode(CoinData.self, from: data)
                        
                        let coinString = String(format: "%.2f", safeData.rate)
                        self.delegate?.updateCoin(currency: coinString)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
                
            }
            task.resume()
        }
    }
}

//MARK: - CoinData

struct CoinData: Codable {
    let rate: Double
}
