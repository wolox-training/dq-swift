//
//  RentalsViewModel.swift
//  WBooks
//
//  Created by Diego Quirós on 3/28/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift

public class RentalsViewModel {
    
    let bookViewModels: Property<[BookViewModel]>
    var nextPage = 1
    
    private let _bookRepository: BookRepositoryType
    private var _bookViewModels = MutableProperty<[BookViewModel]>([])
    
    init(bookRepository: BookRepositoryType) {
        _bookRepository = bookRepository
        bookViewModels = Property<[BookViewModel]>(_bookViewModels)
        
    }
    func getRents() {

//        _bookViewModels <~ _bookRepository.fetchUserRents(userID: 5)
//            .map { rents in rents.map { BookViewModel(book: $0.book) } }
//            .liftError()
//
        
        _bookRepository.fetchUserRents(userID: 5)
            .map {$0.filter {$0.book != nil}
                .map {rent in BookViewModel(book: rent.book!)}}
            .startWithResult { result in
            switch result {

            case .success(let books):
                self._bookViewModels.value += books

            case .failure(let error):
                print(error)
            }
        }
    }
}

internal extension RentalsViewModel {
    
    var count: Int {
        return bookViewModels.value.count
    }
    
    subscript(index: Int) -> BookViewModel {
        return bookViewModels.value[index]
    }
    
}
