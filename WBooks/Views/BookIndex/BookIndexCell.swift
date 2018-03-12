//
//  BookIndexCellTableViewCell.swift
//  WBooks
//
//  Created by Diego Quirós on 3/12/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

struct Book {
    
    let title: String
    let author: [String]
    let description: String
    let image: URL
    
}

class BookIndexCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthors: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(for book: Book) {
        
    }

}
