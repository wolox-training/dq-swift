//
//  BookInformationView.swift
//  WBooks
//
//  Created by Diego Quirós on 3/19/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

import UIKit
import Core

final internal class BookInformationView: UIView, NibLoadable {
    
    @IBOutlet weak var tableView: UITableView!
    
    func configureBookInformation() {

        backgroundColor = UIColor(red: 0.92, green: 0.96, blue: 0.98, alpha: 1)

    }
}
