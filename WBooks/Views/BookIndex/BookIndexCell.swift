//
//  BookIndexCellTableViewCell.swift
//  WBooks
//
//  Created by Diego Quirós on 3/12/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import Core
import Utils
import ReactiveSwift

final internal class BookIndexCell: UITableViewCell, NibLoadable {

    //static let Height: CGFloat = 100.0
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthors: UILabel!
    @IBOutlet weak var cellContainer: UIView!
    
    var disposable: Disposable?
    
    override func prepareForReuse() {
        disposable?.dispose()
        disposable = .none
    }
    
    let imageFetcher: ImageFetcher = ImageFetcher()
    
    func configureCell(for viewModel: BookViewModel) {
        bookTitle.text = viewModel.title
        bookAuthors.text = viewModel.author
        configureImage(url: viewModel.imageURL)

        
        
        cellContainer.layer.cornerRadius = 5
        cellContainer.backgroundColor = UIColor.white
        cellContainer.layer.shadowOffset = CGSize(width: 0, height: 1)
        cellContainer.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        cellContainer.layer.shadowOpacity = 1
        cellContainer.layer.shadowRadius = 1
        
        self.backgroundColor = UIColor(red: 0.92, green: 0.96, blue: 0.98, alpha: 1)
        
    }
}

private extension BookIndexCell {
    
    func configureImage(url: URL?) {
        
        guard let imageURL = url else { return }
        disposable = imageFetcher.fetchImage(imageURL).observe(on: UIScheduler()).startWithResult {[unowned self] result in
            switch result {
            case .success(let image):
                self.bookImage.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
}
