//
//  AddNewViewController.swift
//  WBooks
//
//  Created by Diego Quirós on 3/16/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController {
    
    private lazy var _view: AddNewView = AddNewView.loadFromNib()!

    override func loadView() {
        view = _view
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        _view.configureButton()
    }
    
    override func viewDidLoad() {
        navigationItem.title = "ADD NEW"
        super.viewDidLoad()
        
        _view.configureView()
        
    }

}
