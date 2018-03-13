//
//  BookIndexViewModel.swift
//  WBooks
//
//  Created by Diego Quirós on 3/13/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

internal final class BookIndexViewModel {

    private let _bookViewModels: [BookViewModel]
    
    init() {
        _bookViewModels = [
            Book(
                title: "El principito sdfsdfsdfsdfsdfsdfsdfsdfsdf",
                author: "John Dow",
                description: "Un libro que leen todos en la escuela",
                imageURL: "https://upload.wikimedia.org/wikipedia/en/0/05/Littleprince.JPG"
            )
        ].map { BookViewModel(book: $0) }
    }
}

internal extension BookIndexViewModel {
    
    var count: Int {
        return _bookViewModels.count
    }
    
    subscript(index: Int) -> BookViewModel {
        return _bookViewModels[index]
    }
}
