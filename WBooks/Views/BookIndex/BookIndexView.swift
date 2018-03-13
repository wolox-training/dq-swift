//
//  BookIndexView.swift
//  WBooks
//
//  Created by Diego Quirós on 3/12/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import Core

final internal class BookIndexView: UIView, NibLoadable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarBackground: UIImageView!
    
    func configureView() {
        
        self.backgroundColor = UIColor(red:0.92, green:0.96, blue:0.98, alpha:1)
        tableView.backgroundColor = UIColor(red:0.92, green:0.96, blue:0.98, alpha:1)
        
    }
}
