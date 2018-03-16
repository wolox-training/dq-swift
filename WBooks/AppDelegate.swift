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
        
        /*
         * Uncomment this and remove this comment once Rollbar service is enabled
         * and the keys are properly configured in the configuration files.
         *
        RollbarService().initialize()
         *
         */
                
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = ViewController { [unowned self] _ in
//            let networkingConfiguration = NetworkingConfiguration(
//                useSecureConnection: false,
//                domainURL: "wbooks-api-stage.herokuapp.com",
//                subdomainURL: "/api/v1",
//                usePinningCertificate: false
//            )
            
           /* let booksRepository = BookRepository(
                networkingConfiguration: networkingConfiguration,
                sessionManager: GoogleLoginService.shared.sessionManager
            )*/

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
                //BookIndexController(bookIndexViewModel: BookIndexViewModel(bookRepository: booksRepository))
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

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. 
        // This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) 
        // or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. 
        // Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough application state information to restore your application to its current state 
        // in case it is terminated later.
        // If your application supports background execution, this method is called instead of 
        // applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; 
        // here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. 
        // If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. 
        // See also applicationDidEnterBackground:.
    }
}
