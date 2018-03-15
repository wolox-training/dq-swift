//
//  LoginService.swift
//  WBooks
//
//  Created by Diego Quirós on 3/9/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Result
import GoogleSignIn

struct User {
    
    let email: String
    
}

enum LoginError: Error {
    
    case invalidCredentials
    
}

protocol LoginService {
    
    func login(callback: @escaping (Result<User, LoginError>) -> Void)
    
}

final class GoogleLoginService: NSObject, LoginService, GIDSignInDelegate, GIDSignInUIDelegate {
    
    static let shared = GoogleLoginService()
    
    private let googleService = GIDSignIn.sharedInstance()!
    private var presenter: UIViewController? = .none
    
    private override init() { }
    
    func bootstrap(clientId: String, presenter: UIViewController) {
        googleService.clientID = clientId
        googleService.delegate = self
        googleService.uiDelegate = self
        self.presenter = presenter
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // TODO construir el result
        if error != nil {
            print(error)
        } else if user != nil {
            print(user)
        } else {
            print("WTF!")
        }
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        presenter?.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func handle(url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
        let sourceApplication = options[.sourceApplication] as? String
        let annotation: Any! = options[.annotation]
        return googleService.handle(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func login(callback: @escaping (Result<User, LoginError>) -> Void) {
        if googleService.currentUser != nil {
            
        } else {
            googleService.signIn()
        }
    }
    
}
