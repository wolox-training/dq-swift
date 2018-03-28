//
//  RentalsView.swift
//  WBooks
//
//  Created by Diego Quirós on 3/28/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import Core

class RentalsView: UIView, NibLoadable {
    @IBOutlet weak var tableView: UITableView!
    
    func configureView() {
        backgroundColor = UIColor(red: 0.92, green: 0.96, blue: 0.98, alpha: 1)
        tableView.backgroundColor = UIColor(red: 0.92, green: 0.96, blue: 0.98, alpha: 1)
    }
    
}
