//
//  ViewController.swift
//  WBooks
//
//  Created by Guido Marucci Blas on 4/3/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit
import Core
import GoogleSignIn

final class ViewController: UIViewController {
    
    private var customView: View {
        return view as! View // swiftlint:disable:this force_cast
    }
    
    private let loginService: LoginService
    
    init(loginService: LoginService = GoogleLoginService.shared) {
        self.loginService = loginService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = View.loadFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.onTap = { [weak self] in self?.login() }
    }

}

fileprivate extension ViewController {
    
    func login() {
        loginService.login { result in
            switch result {
            case .success(let user):
                print("User successfully logged in \(user.email)")
            case .failure(let error):
                self.presentErrorAlert(error: error)
            }
        }
    }
    
    func presentErrorAlert(error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: "There was an error loging in: \(error)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
