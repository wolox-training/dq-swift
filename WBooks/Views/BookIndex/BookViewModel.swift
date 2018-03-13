//
//  BookViewModel.swift
//  WBooks
//
//  Created by Diego Quirós on 3/13/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

internal final class BookViewModel {

    private let _book: Book
    
    init(book: Book) {
        _book = book
    }
    
    var title: String {
        return _book.title
    }
    
    var author: String {
        return _book.author
    }
    
    var description: String {
        return _book.description
    }
    
    var imageURL: URL? {
        return URL(string: _book.imageURL)
    }
}
