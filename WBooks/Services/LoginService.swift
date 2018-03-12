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
    
    let userId: String
    
}

fileprivate extension User {
    
    static func from(googleUser: GIDGoogleUser) -> User {
        return User(userId: googleUser.userID)
    }
    
}

enum LoginError: Error {
    
    case alreadyLogginIn
    case serviceProviderFailure(Error)
    
}

protocol LoginService {
    
    func login(callback: @escaping (Result<User, LoginError>) -> Void)
    
}

final class GoogleLoginService: NSObject, LoginService, GIDSignInDelegate, GIDSignInUIDelegate {
    
    static let shared = GoogleLoginService()
    
    private let googleService = GIDSignIn.sharedInstance()!
    private var presenter: UIViewController? = .none
    private var callback: ((Result<User, LoginError>) -> Void)? = .none
    
    private override init() { }
    
    func bootstrap(clientId: String, presenter: UIViewController) {
        googleService.clientID = clientId
        googleService.delegate = self
        googleService.uiDelegate = self
        self.presenter = presenter
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        let result: Result<User, LoginError>
        if error != nil {
            result = .failure(.serviceProviderFailure(error))
        } else if user != nil {
            result = .success(User.from(googleUser: user))
        } else {
            fatalError("There is not error nor user!")
        }
        
        if let callback = self.callback {
            self.callback = .none
            callback(result)
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
        guard self.callback == nil else {
            callback(.failure(.alreadyLogginIn))
            return
        }
        if googleService.currentUser != nil {
            let user = User.from(googleUser: googleService.currentUser)
            callback(.success(user))
        } else {
            self.callback = callback
            googleService.signIn()
        }
    }
    
}
