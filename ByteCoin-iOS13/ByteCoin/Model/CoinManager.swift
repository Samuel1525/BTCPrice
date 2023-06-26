//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdatePrice(_ coinManager: CoinManager, currentRate: Double, currency: String)
    func didFailWithError(error: Error)
    
}

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apikey = "25690ED4-E3EC-4397-BA70-E2A33A31A73B"
    
    var delegate : CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)/?apikey=\(apikey)"
        
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
    //                    let dataString = String(data: safeData, encoding: .utf8)
                    if let lastprice = self.parseJSON(safeData){
                        self.delegate?.didUpdatePrice(self, currentRate: lastprice, currency: currency)
//                        print(lastprice)
                    }
                    
                    }
                    
                
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ moneyData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: moneyData)
            //Data weather dibuat
            let lastprice = decodedData.rate
            return lastprice
        } catch {
            print(error)
            return nil
        }
    }
    
}


