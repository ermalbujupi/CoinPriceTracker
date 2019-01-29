//
//  CoinPriceMainView.swift
//  CoinPrice
//
//  Created by Ermal Bujupaj on 28.01.19.
//  Copyright © 2019 Ermal Bujupaj. All rights reserved.
//

import UIKit

protocol CoinPriceMainViewDelegate {
    func changedSegmentValue(_ priceMainView: CoinPriceMainView, _ sender: UISegmentedControl)
}

class CoinPriceMainView: UIView {

    var price: String = "Price" {
        didSet {
            priceLabel.text = price
        }
    }

    var delegate: CoinPriceMainViewDelegate?
    private var coinLogo: UIImageView!
    private var priceLabel: UILabel!
    
    var coinControl: UISegmentedControl!
    var currencyPicker: UIPickerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 82/255, green: 150/255, blue: 179/255, alpha: 1)
        
        coinLogo = UIImageView()
        coinLogo.image = UIImage()
        self.addSubview(coinLogo)
        
        priceLabel = UILabel()
        priceLabel.text = "Price"
        priceLabel.textColor = UIColor(red:1.00, green:0.78, blue:0.00, alpha:1.0)
        priceLabel.font = UIFont (name: "HelveticaNeue-Bold", size: 40)
        self.addSubview(priceLabel)
        
        coinControl = UISegmentedControl()
        coinControl.insertSegment(withTitle: "Bitcoin", at: 0, animated: true)
        coinControl.insertSegment(withTitle: "Etherum", at: 1, animated: true)
        coinControl.backgroundColor = UIColor(red:1.00, green:0.78, blue:0.00, alpha:1.0)
        coinControl.tintColor = .white
        coinControl.selectedSegmentIndex = 0
        coinControl.addTarget(self, action: #selector(didTapCoinControl), for: .valueChanged)
        self.addSubview(coinControl)
        
        currencyPicker = UIPickerView()
        self.addSubview(currencyPicker)
        
        setupConstraints()
    }
    
    @objc private func didTapCoinControl(_ sender: UISegmentedControl) {
        delegate?.changedSegmentValue(self, sender)
    }
    
    private func setupConstraints() {
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        coinLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        coinLogo.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        coinControl.translatesAutoresizingMaskIntoConstraints = false
        coinControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        coinControl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        coinControl.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 80).isActive = true
        
        currencyPicker.translatesAutoresizingMaskIntoConstraints = false
        currencyPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        currencyPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        currencyPicker.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
