//
//  BookIndexCellTableViewCell.swift
//  WBooks
//
//  Created by Diego Quirós on 3/12/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import Core

final internal class BookIndexCell: UITableViewCell, NibLoadable {

    static let Height: CGFloat = 90.0
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthors: UILabel!
    
    func configureCell(for viewModel: BookViewModel) {
        bookTitle.text = viewModel.title
        bookAuthors.text = viewModel.author
        configureImage(urlBook: viewModel.imageURL)
        
        
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.white
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.05).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1
    }
}

private extension BookIndexCell {
    
    func configureImage(urlBook: URL?) {
        guard let url = urlBook else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed fetching image \(error.debugDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            DispatchQueue.main.async {
                self.bookImage.image = UIImage(data: data!)
            }
        }.resume()
    }
}
