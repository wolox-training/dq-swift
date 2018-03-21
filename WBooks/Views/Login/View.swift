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
    
    var onTap: (() -> Void)? = .none
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setButtonBorder(radius: 25, width: 2)
        logInButton.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
    }
    
}

// MARK: - Private Methods
fileprivate extension View {
    
    func setButtonBorder(radius: CGFloat, width: CGFloat) {
        logInButton.layer.cornerRadius = radius
        logInButton.layer.borderWidth = width
        logInButton.layer.borderColor = UIColor.white.cgColor
        logInButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
        logInButton.sizeToFit()
    }
    
    @objc func onTap(_ sender: Any) {
        onTap?()
    }
    
}
