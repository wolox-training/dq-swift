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
import Networking

public struct User: AuthenticableUser {
    
    public let userId: String
    
    public var sessionToken: String? {
        return "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNDksInZlcmlmaWNhdGlvbl9jb2RlIjoiZkNmQWJ1bmpfS0xmVkp6cjhIeWQ3dHc1VlJSa1ZNQi1iNFhZWnlHd0pYc3NMenpUVm1uY3RHLTVGcFBxRHhocyIsInJlbmV3X2lkIjoiY3RTVjJ5X3hyc0hKSm55dzZCblhXMmlfUFozdnpiWTZFc3hTRjFVZ2ZzSnJvRDRrb0YteXpvdjFfY3lUOUh3diIsIm1heGltdW1fdXNlZnVsX2RhdGUiOjE1MjM2MzQ2NTgsImV4cGlyYXRpb25fZGF0ZSI6MTUyMTIxNTQ1OCwid2FybmluZ19leHBpcmF0aW9uX2RhdGUiOjE1MjEwNjA2NTh9.OML6xqc7vrIXsBeVdZnyIJ5v23kz1gA7qSTscGSXD5Y"
    }

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
    
    public let sessionManager = SessionManager()

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
            let authenticatedUser = User.from(googleUser: user)
            result = .success(authenticatedUser)
            sessionManager.login(user: authenticatedUser)
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
