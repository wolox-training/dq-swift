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
    
    var id: Int {
        return _book.id
    }
    
    var publisher: String {
        return _book.publisher
    }
    
    var year: String {
        return _book.year
    }
    
    var genre: String {
        return _book.genre
    }
    
    var title: String {
        return _book.title
    }
    
    var author: String {
        return _book.author
    }
    
    var imageURL: URL? {
        return _book.imageURL
    }

}
