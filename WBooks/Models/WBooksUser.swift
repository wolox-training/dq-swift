//
//  WBooksUser.swift
//  WBooks
//
//  Created by Diego Quirós on 3/22/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

internal struct WBooksUser {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let imageURL: URL?
    let rentsCounter: Int
    let commentsCounter: Int
    let unreadNotificationsCount: Int
    
    init(id: Int, firstName: String, lastName: String, email: String, imageURL: String?,
         rentsCounter: Int, commentsCounter: Int, unreadNotificationsCount: Int) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.imageURL = imageURL.map { URL(string: $0)! }
        self.rentsCounter = rentsCounter
        self.commentsCounter = commentsCounter
        self.unreadNotificationsCount = unreadNotificationsCount
    }
}

extension WBooksUser: Argo.Decodable {
    
    public static func decode(_ json: JSON) -> Decoded<WBooksUser> {
        let part1 = curry(WBooksUser.init)
            <^> json <| "id"
            <*> json <| "first_name"
            <*> json <| "last_name"
            <*> json <| "email"
            
        return part1
            <*> json <|? "image_url"
            <*> json <| "rents_counter"
            <*> json <| "comments_counter"
            <*> json <| "unread_notifications_count"
        
    }
    
}
