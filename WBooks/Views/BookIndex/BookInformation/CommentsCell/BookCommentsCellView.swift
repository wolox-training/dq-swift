//
//  BookCommentCellView.swift
//  WBooks
//
//  Created by Diego Quirós on 3/21/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import Core
import Utils
import ReactiveSwift

class BookCommentsCellView: UITableViewCell, NibLoadable {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userComment: UILabel!
    
    var disposable: Disposable?
    let imageFetcher: ImageFetcher = ImageFetcher()
    
    override func prepareForReuse() {
        disposable?.dispose()
        disposable = .none
    }
    
    func configureCell(comment: Comment) {
        configureImage(url: comment.user.imageURL)
        userComment.text = comment.content
        userName.text = comment.user.fullName
        
        self.selectionStyle = .none
        
    }
}

private extension BookCommentsCellView {
    
    func configureImage(url: URL?) {
        
        guard let imageURL = url else { return }
        disposable = imageFetcher.fetchImage(imageURL).observe(on: UIScheduler()).startWithResult {[unowned self] result in
            switch result {
            case .success(let image):
                self.userImage.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
}
