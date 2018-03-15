//
//  Book.swift
//  WBooks
//
//  Created by Diego Quirós on 3/13/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

internal struct Book {
    
    let id: Int
    let title: String
    let author: String
    let imageURL: URL?
    let publisher: String
    let year: String
    let genre: String
    
    init(id: Int, title: String, author: String, imageURL: String?, publisher: String, year: String, genre: String) {
        self.id = id
        self.title = title
        self.author = author
        self.imageURL = imageURL.map { URL(string: $0)! }
        self.publisher = publisher
        self.year = year
        self.genre = genre
    }
    
}

extension Book: Argo.Decodable {
    
    public static func decode(_ json: JSON) -> Decoded<Book> {
        let part1 = curry(Book.init)
            <^> json <| "id"
            <*> json <| "title"
            <*> json <| "author"
            <*> json <|? "image_url"
        
        return part1
            <*> json <| "publisher"
            <*> json <| "year"
            <*> json <| "genre"
    }
    
}
