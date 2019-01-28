//
//  ViewController.swift
//  CoinPrice
//
//  Created by Ermal Bujupaj on 28.01.19.
//  Copyright © 2019 Ermal Bujupaj. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {

    let bitcoinBaseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let etherBaseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/ETH"

    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var bitcoinFinalURL = ""
    var etherFinalURL = ""
    var currentSymbol = ""

    var mainView: CoinPriceMainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = CoinPriceMainView(frame: CGRect.zero)
        self.view.addSubview(mainView)
        
        mainView.currencyPicker.delegate = self
        mainView.currencyPicker.dataSource = self
        
        setupConstraints()
    }
    
    private func getBitcoinPrice(url: String) {
        Alamofire.request(url, method: .get).responseJSON { response in
            if response.result.isSuccess {
                let bitcoinJSON = JSON(response.result.value!)
                self.updatePrice(json: bitcoinJSON)
                print(bitcoinJSON)
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.mainView.price = "Connection Issues"
            }
        }
    }
    
    private func updatePrice(json: JSON) {
        if let price = json["open"]["day"].double {
            self.mainView.price = currentSymbol + "\(price)"
        }
    }
    
    private func setupConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }

}

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bitcoinFinalURL = bitcoinBaseURL + currencyArray[row]
        currentSymbol = currencySymbolArray[row]
        getBitcoinPrice(url: bitcoinFinalURL)
    }
    
}
