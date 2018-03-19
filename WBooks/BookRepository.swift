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
    
    func fetchBooks(page: Int) -> SignalProducer<[Book], RepositoryError>
    
}

internal class BookRepository: AbstractRepository, BookRepositoryType {
    
    private static let PageKey = "page"
    
    public func fetchBooks(page: Int) -> SignalProducer<[Book], RepositoryError> {
        let parameters = [BookRepository.PageKey: page, "amount": 10]
        return performRequest(method: .get, path: "/books", parameters: parameters) {
            return decode($0).toResult()
        }
    }
}
