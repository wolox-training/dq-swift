//
//  BookIndexViewModel.swift
//  WBooks
//
//  Created by Diego Quirós on 3/13/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import ReactiveSwift

internal final class BookIndexViewModel {

    var bookViewModels: MutableProperty<[BookViewModel]> = MutableProperty([])
    
    private let _bookRepository: BookRepositoryType
    
    init(bookRepository: BookRepositoryType) {
        
        _bookRepository = bookRepository
        
        bookViewModels <~ bookRepository.fetchBooks()
            .map { $0.map { BookViewModel(book: $0) }  }
            .liftError()
        
//        bookRepository.fetchBooks()
//            .map { $0.map { BookViewModel(book:$0) }  }
//            .startWithValues { [unowned self] booksViewModel in
//                self._bookViewModels.value = booksViewModel
//            }
        
            /*Book(
                title: "El principito sdfsdfsdfsdfsdfsdfsdfsdfsdf",
                author: "John Dow",
                description: "Un libro que leen todos en la escuela",
                imageURL: "https://upload.wikimedia.org/wikipedia/en/0/05/Littleprince.JPG"
            )
        ].map { BookViewModel(book: $0) }*/
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
