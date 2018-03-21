//
//  AppDelegate.swift
//  WBooks
//
//  Created by Guido Marucci Blas on 4/3/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit
import GoogleSignIn
import Networking
import AlamofireNetworkActivityLogger
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if Environment.isTestTarget {
            return true
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = ViewController { [unowned self] _ in

            NetworkActivityLogger.shared.level = .debug
            NetworkActivityIndicatorManager.shared.isEnabled = true
            NetworkActivityLogger.shared.startLogging()
            let navBarAppearence = UINavigationBar.appearance()
            
            navBarAppearence.setBackgroundImage(UIImage(), for: .default)
            navBarAppearence.shadowImage = UIImage()
            navBarAppearence.isTranslucent = true
            navBarAppearence.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            
            let navBarViewController = TabBarViewController()
            
            self.window?.rootViewController = navBarViewController
            
        }
        GoogleLoginService.shared.bootstrap(
            clientId: "121090626106-ce89jpgcrf8ga811ucd5sk2nl55mcumm.apps.googleusercontent.com",
            presenter: rootViewController
        )
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }

    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        return GoogleLoginService.shared.handle(url: url, options: options)
    }

}
