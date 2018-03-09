//
//  ViewController.swift
//  WBooks
//
//  Created by Guido Marucci Blas on 4/3/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit
import Core

final class ViewController: UIViewController {
    
    private var customView: View {
        return view as! View // swiftlint:disable:this force_cast
    }
    
    override func loadView() {
        view = View.loadFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        /*customView.configureView(labelText: "Welcome! This is a new blank project using Xibs!", buttonTitle: "Boton") {
            let alert = UIAlertController(title: "Alert", message: "Hola!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
