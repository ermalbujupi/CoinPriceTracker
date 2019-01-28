//
//  ViewController.swift
//  CoinPrice
//
//  Created by Ermal Bujupaj on 28.01.19.
//  Copyright © 2019 Ermal Bujupaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var mainView: CoinPriceMainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = CoinPriceMainView(frame: CGRect.zero)
        self.view.addSubview(mainView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }


}

