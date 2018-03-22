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
    var nextPage = 1
    

    private let _bookRepository: BookRepositoryType
    private var _bookViewModels = MutableProperty<[BookViewModel]>([])
    
    init(bookRepository: BookRepositoryType) {
        _bookRepository = bookRepository
        bookViewModels = Property<[BookViewModel]>(_bookViewModels)
        
    }
    
    func getMoreBooks() {
        _bookRepository.fetchBooks(page: nextPage)
            .map { $0.map { BookViewModel(book: $0) } }
            .take(first: 1)
            .startWithResult { result in
                switch result {
                    
                case .success(let books):
                    self._bookViewModels.value += books
                    self.nextPage += 1
                    
                case .failure(let error):
                    print(error)
                }
            }
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
