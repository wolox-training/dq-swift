//
//  BookRepository.swift
//  WBooks
//
//  Created by Diego Quirós on 3/14/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Networking
import Argo
import Result
import ReactiveSwift
import GoogleSignIn

protocol BookRepositoryType {
    
    func fetchBooks() -> SignalProducer<[Book], RepositoryError>
    
}

internal class BookRepository: AbstractRepository, BookRepositoryType {
    
    public func fetchBooks() -> SignalProducer<[Book], RepositoryError> {
        return performRequest(method: .get, path: "/books", parameters: nil) {
            return decode($0).toResult()
        }
    }
    
}
