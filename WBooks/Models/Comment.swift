//
//  Comment.swift
//  WBooks
//
//  Created by Diego Quirós on 3/22/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

internal struct Comment {
    
    let id: Int
    let content: String
    let book: Book
    let user: WBooksUser
}

extension Comment: Argo.Decodable {
    
    public static func decode(_ json: JSON) -> Decoded<Comment> {
        return curry(Comment.init)
            <^> json <| "id"
            <*> json <| "content"
            <*> json <| "book"
            <*> json <| "user"
    
    }
    
}
