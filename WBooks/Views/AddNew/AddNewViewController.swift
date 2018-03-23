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
    
    override func viewDidLoad() {
        navigationItem.title = "ADD NEW"
        super.viewDidLoad()
        
        _view.configureView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
