//
//  BookIndexViewModel.swift
//  WBooks
//
//  Created by Diego Quirós on 3/13/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import ReactiveSwift
import enum Result.NoError

internal final class BookIndexViewModel {

    let navigationTitle = "LIBRARY"
    let tabBarTitle = "Library"
    let bookViewModels: Property<[BookViewModel]>
    
    fileprivate let _bookViewModels = MutableProperty<[BookViewModel]>([])
    fileprivate let _bookRepository: BookRepositoryType
    
    init(bookRepository: BookRepositoryType) {
        _bookRepository = bookRepository
        bookViewModels = Property(_bookViewModels)
    }
    
    func initializeBookRepository() {
        _bookViewModels <~ _bookRepository.fetchBooks()
            .map { $0.map { BookViewModel(book: $0) } }
            .liftError()
    }
}

internal extension BookIndexViewModel {
    
    var count: Int {
        return bookViewModels.value.count
    }
    
    subscript(index: Int) -> BookViewModel {
        return bookViewModels.value[index]
    }
    
}
