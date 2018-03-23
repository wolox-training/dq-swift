//
//  BookCommentCellView.swift
//  WBooks
//
//  Created by Diego Quirós on 3/21/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import Core

class BookCommentsCellView: UITableViewCell, NibLoadable {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userComment: UILabel!
    
    func configureCell(comment: Comment) {
        userComment.text = comment.content
        userName.text = "\(comment.user.firstName) \(comment.user.lastName)"
        
    }
}
