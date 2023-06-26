//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var coinManager = CoinManager()
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencyname = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currencyname)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    

    @IBOutlet weak var currencyLabel: UILabel!
    
    
    @IBOutlet weak var bitcoinLabel: UILabel!

    

    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }

}

extension ViewController: CoinManagerDelegate{
    func didUpdatePrice(_ coinManager: CoinManager, currentRate: Double, currency: String) {
//        self.currencyLabel.text = String(format: "%.1f", currentRate)
        DispatchQueue.main.async {
            self.currencyLabel.text = currency
            self.bitcoinLabel.text = String(format: "%.1f", currentRate)
        }
    }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}