//
//  BookInformationViewModel.swift
//  WBooks
//
//  Created by Diego Quirós on 3/22/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import enum Result.NoError

internal final class BookInformationViewModel {
    
    var bookID: Int
    private var _comments = MutableProperty<[Comment]>([])
    let comments: Property<[Comment]>
    private var _rents = MutableProperty<[Rent]>([])
    let rents: Property<[Rent]>
    private let wBooksRepository: WBooksRepository = RepositoryCreator.shared.bookRepository
    
    init(bookID: Int) {


        self.bookID = bookID
        comments = Property<[Comment]>(_comments)
        rents = Property<[Rent]>(_rents)
        getComments()
        getRents()
    }
    
    func getComments() {
        
        wBooksRepository.fetchComments(bookID: bookID).take(first: 1).startWithResult { result in
            switch result {
                
            case .success(let comments):
                self._comments.value += comments
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func getRents() {
        
        wBooksRepository.fetchRents(bookID: bookID).take(first: 1).startWithResult { result in
            switch result {
                
            case .success(let rents):
                self._rents.value += rents
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func isAvailable() -> Bool {
        if (rents.value.filter { $0.returnedAt == nil}.isEmpty) {
            return true
        }
        return false
    }
}

internal extension BookInformationViewModel {
    
    var count: Int {
        return _comments.value.count
    }
    
    subscript(index: Int) -> Comment {
        return _comments.value[index]
    }
}
