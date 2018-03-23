//
//  TabBarViewController.swift
//  WBooks
//
//  Created by Diego Quirós on 3/15/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import Networking
import AlamofireNetworkActivityLogger
import AlamofireNetworkActivityIndicator

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
}

// MARK: - Private Methods
fileprivate extension TabBarViewController {
    

    func configureTabBar() {
//        let networkingConfiguration = NetworkingConfiguration(
//            useSecureConnection: false,
//            domainURL: "wbooks-api-stage.herokuapp.com",
//            subdomainURL: "/api/v1",
//            usePinningCertificate: false)
//
//        let booksRepository = BookRepository(
//            networkingConfiguration: networkingConfiguration,
//            sessionManager: GoogleLoginService.shared.sessionManager
//        )

        tabBar.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9).cgColor
        
        let libraryViewController = UINavigationController(
            rootViewController: BookIndexController(

                bookIndexViewModel: BookIndexViewModel(bookRepository: RepositoryCreator.shared.bookRepository)

            )
        )
        
        setupTabBarItem(
            controller: libraryViewController,
            title: "Library",
            image: "ic_library.png",
            selectedImage: "ic_library active.png",
            tag: 0)
        
        let wishlistViewController = UINavigationController(
            rootViewController: WishlistViewController()
        )
        
        setupTabBarItem(
            controller: wishlistViewController,
            title: "Wishlist",
            image: "ic_wishlist.png",
            selectedImage: "ic_wishlist active.png",
            tag: 1)
        
        let addNewViewController = UINavigationController(
            rootViewController: AddNewViewController()
        )
        
        setupTabBarItem(
            controller: addNewViewController,
            title: "Add New",
            image: "ic_add new.png",
            selectedImage: "ic_add new active.png",
            tag: 2)
        
        let rentalsViewController = UINavigationController(
            rootViewController: RentalsViewController()
        )
        
        setupTabBarItem(
            controller: rentalsViewController,
            title: "Rentals",
            image: "ic_myrentals.png",
            selectedImage: "ic_myrentals active.png",
            tag: 3)
        
        viewControllers = [libraryViewController, wishlistViewController, addNewViewController, rentalsViewController]
    }
    
    func setupTabBarItem(controller: UIViewController, title: String, image: String, selectedImage: String, tag: Int) {
        controller.tabBarItem = UITabBarItem()
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(named: image)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)
        controller.tabBarItem.tag = tag
    }
    
}
