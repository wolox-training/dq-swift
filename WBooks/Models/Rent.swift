//
//  Rent.swift
//  WBooks
//
//  Created by Diego Quirós on 3/23/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Foundation
import Argo
import Curry
import Runes

internal struct Rent {
    
    let id: Int
    let from: String
    let to: String
    let returnedAt: String?
    let book: Book?
    let user: WBooksUser
}

extension Rent: Argo.Decodable {
    
    public static func decode(_ json: JSON) -> Decoded<Rent> {
        let part1 = curry(Rent.init)
            <^> json <| "id"
            <*> json <| "from"
            <*> json <| "to"
           
        return part1
            <*> json <|? "returned-at"
            <*> json <|? "book"
            <*> json <| "user"
        
    }
    
}
