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
    
    func initializeBookRepository() {
            
            _bookRepository.fetchBooks()
                .map({ (books) -> [BookViewModel] in
                    return books.map({ (book) -> BookViewModel in
                        return BookViewModel(book: book)
                    })
                })
                .startWithResult { [unowned self] result in
                    switch result {
                    case .success(let bookViewModel):
                        self.bookViewModels.value = bookViewModel
                        
                    case .failure(let error):
                        print(error)
                    }
        }
    }
    
    init(bookRepository: BookRepositoryType) {
        
        _bookRepository = bookRepository
        
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
