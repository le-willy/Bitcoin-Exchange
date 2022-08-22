//
//  ViewController.swift
//  BitcoinExchange
//
//  Created by Willy Sato on 2022/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        coinManager.delegate = self
        
        view.backgroundColor = .systemGreen
        
        priceLabel.text = "Price"
        currencyLabel.text = "AUD"
        
        titleLabel.text = ""
        var time = 0.0
        let titleText = "Bitcoin Exchange"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * time, repeats: false) {
                time in
                self.titleLabel.text?.append(letter)
            }
            time += 1
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        coinManager.fechData(with: coinManager.currencyArray[row])
        currencyLabel.text = coinManager.currencyArray[row]
    }
    
}

extension ViewController: CoinManagerDelegate {
    func updateCoin(currency: String) {
        DispatchQueue.main.async {
            self.priceLabel.text = currency

        }
    }
}
