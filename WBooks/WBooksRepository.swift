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
    func fetchComments(bookID: Int) -> SignalProducer<[Comment], RepositoryError>
    
}

internal class WBooksRepository: AbstractRepository, BookRepositoryType {
    
    private static let PageKey = "page"
    
    public func fetchBooks(page: Int) -> SignalProducer<[Book], RepositoryError> {
        let parameters = [WBooksRepository.PageKey: page, "amount": 10]
        return performRequest(method: .get, path: "/books", parameters: parameters) {
            return decode($0).toResult()
        }
    }
    
    public func fetchComments(bookID: Int) -> SignalProducer<[Comment], RepositoryError> {
        return performRequest(method: .get, path: "/books/\(bookID)/comments", parameters: nil) {
            return decode($0).toResult()
        }
    }
    
    public func fetchRents(bookID: Int) -> SignalProducer<[Rent], RepositoryError> {
        return performRequest(method: .get, path: "/books/\(bookID)/rents", parameters: nil) {
            return decode($0).toResult()
        }
    }
}
