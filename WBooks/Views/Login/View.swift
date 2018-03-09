//
//  View.swift
//  WBooks
//
//  Created by Diego Quirós on 3/8/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import UIKit
import Core

final class View: UIView, NibLoadable {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var wBooksLogo: UIImageView!
    @IBOutlet weak var logInButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setButtonBorder(radius: 15, width: 1.5)
    }
    
   /* @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    private var onTap: (() -> Void)? = .none
    
    func configureView(labelText: String, buttonTitle: String, onTap: @escaping () -> Void) {
        label.text = labelText
        label.sizeToFit()
        
        button.setTitle(buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
    
        self.onTap = onTap
    }
    
    @objc func onTap(_ sender: Any) {
        onTap?()
    }*/
    
}

// MARK: - Private Methods
fileprivate extension View {
    
    func setButtonBorder(radius: CGFloat, width: CGFloat) {
        logInButton.layer.cornerRadius = radius
        logInButton.layer.borderWidth = width
        logInButton.layer.borderColor = UIColor.white.cgColor
        //        logInButton.titleEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20)
        logInButton.contentEdgeInsets = UIEdgeInsetsMake(5, 20, 5, 20)
        logInButton.sizeToFit()
    }
    
}
