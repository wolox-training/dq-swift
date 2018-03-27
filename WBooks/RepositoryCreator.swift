//
//  RepositoryCreator.swift
//  WBooks
//
//  Created by Diego Quirós on 3/22/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Networking
import AlamofireNetworkActivityLogger
import AlamofireNetworkActivityIndicator

public class RepositoryCreator {
    
    static let shared = RepositoryCreator()
    
    let bookRepository: WBooksRepository
    
   init() {
        let networkingConfiguration = NetworkingConfiguration(
            useSecureConnection: false,
            domainURL: "wbooks-api-stage.herokuapp.com",
            subdomainURL: "/api/v1",
            usePinningCertificate: false)
        
        self.bookRepository = WBooksRepository(
            networkingConfiguration: networkingConfiguration,
            sessionManager: GoogleLoginService.shared.sessionManager
        )
    }
    
}
