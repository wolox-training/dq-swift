//
//  AddNewView.swift
//  WBooks
//
//  Created by Diego Quirós on 3/23/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Core

public class AddNewView: UIView, NibLoadable {
    
    @IBOutlet weak var formContainer: UIView!
    @IBOutlet weak var imageButton: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var author: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var topic: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var descript: UITextField!
    @IBOutlet weak var bookImage: UIImageView!
    
    func configureButton() {
        submitButton.blueGradient()
        submitButton.titleLabel?.text = "Submit"
        submitButton.titleLabel?.textColor = .white
    }
    
    func configureView() {
        
        backgroundColor = UIColor(red: 0.92, green: 0.96, blue: 0.98, alpha: 1)
        
        formContainer.layer.cornerRadius = 5
        formContainer.backgroundColor = UIColor.white
        formContainer.layer.shadowOffset = CGSize(width: 0, height: 1)
        formContainer.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        formContainer.layer.shadowOpacity = 1
        formContainer.layer.shadowRadius = 1
        
        year.underlined()
        author.underlined()
        name.underlined()
        topic.underlined()
        descript.underlined()
        
//        submitButton.titleLabel?.text = "SUBMIT"
        submitButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
//        submitButton.layer.cornerRadius = 25
//        submitButton.blueGradient()
        
    }
    
}

extension UITextField {
    
    func underlined() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,
                              width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
