//
//  BookInformationCellView.swift
//  WBooks
//
//  Created by Diego Quirós on 3/21/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import Core
import Utils
import ReactiveSwift

class BookInformationCellView: UITableViewCell, NibLoadable {
    
    @IBOutlet weak var bookInformationContainer: BookInformationCellView!
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAvailability: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookYear: UILabel!
    @IBOutlet weak var bookGenre: UILabel!
    @IBOutlet weak var wishlistButton: UIButton!
    @IBOutlet weak var rentButton: UIButton!
    
    var available: Bool = false
    
    var disposable: Disposable?
    let imageFetcher: ImageFetcher = ImageFetcher()
    
    override func prepareForReuse() {
        disposable?.dispose()
        disposable = .none
    }
    
    override func layoutSubviews() {
        if let button = rentButton {
            rentButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
            rentButton.blueGradient()
            if !available {
                bookAvailability.textColor = UIColor(red: 0.82, green: 0.01, blue: 0.11, alpha: 1)
                bookAvailability.text = "Not Available"
                rentButton.isEnabled = false
                
                rentButton.greyGradient()
                
            }
        }
    }
    
    func configureCell(for viewModel: BookViewModel, isAvailable: Bool) {
        
        self.available = isAvailable
        configureImage(url: viewModel.imageURL)
        bookTitle.text = viewModel.title
        bookAuthor.text = viewModel.author
        bookYear.text = viewModel.year
        bookGenre.text = viewModel.genre
        
        bookInformationContainer.layer.cornerRadius = 5
        bookInformationContainer.backgroundColor = UIColor.white
        bookInformationContainer.layer.shadowOffset = CGSize(width: 0, height: 1)
        bookInformationContainer.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        bookInformationContainer.layer.shadowOpacity = 1
        bookInformationContainer.layer.shadowRadius = 1
        
        wishlistButton.layer.cornerRadius = 25
        wishlistButton.setTitleColor(UIColor(red: 0, green: 0.68, blue: 0.93, alpha: 1), for: .normal)
        wishlistButton.backgroundColor = UIColor.white
        wishlistButton.layer.borderWidth = 1
        wishlistButton.layer.borderColor = UIColor(red: 0, green: 0.68, blue: 0.93, alpha: 1).cgColor
        wishlistButton.sizeToFit()
        wishlistButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        
//        rentButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
//
//        rentButton.blueGradient()
        rentButton.layer.cornerRadius = 25
        
        bookImage.image = UIImage(named: "img_book6")
        
        backgroundColor = UIColor(red: 0.92, green: 0.96, blue: 0.98, alpha: 1)
        
        bookAvailability.textColor = UIColor(red: 0.65, green: 0.8, blue: 0.22, alpha: 1)
        bookAvailability.text = "Available"
        
//        if !isAvailable {
//            bookAvailability.textColor = UIColor(red: 0.82, green: 0.01, blue: 0.11, alpha: 1)
//            bookAvailability.text = "Not Available"
//            rentButton.isEnabled = false
//
//            rentButton.greyGradient()
//
//        }
        
    }

}

extension UIButton {
    
    func greyGradient() {
        let gradient = CAGradientLayer()
//        print(self.bounds)
        gradient.frame = self.bounds
//        gradient.frame = CGRect(x: 0, y: 0, width: 275, height: 50)
        gradient.colors = [
            UIColor(red: 0.79, green: 0.79, blue: 0.79, alpha: 1).cgColor,
            UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1).cgColor,
            UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1).cgColor
        ]
        gradient.locations = [0, 0.45230788, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.cornerRadius = 25
        self.layer.addSublayer(gradient)
        
    }
    
    func blueGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
//        gradient.frame = CGRect(x: 0, y: 0, width: 275, height: 50)
        gradient.colors = [
            UIColor(red: 0, green: 0.68, blue: 0.93, alpha: 1).cgColor,
            UIColor(red: 0.22, green: 0.8, blue: 0.8, alpha: 1).cgColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.06, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.cornerRadius = 25
        self.layer.addSublayer(gradient)
    }
    
}

private extension BookInformationCellView {
    
    func configureImage(url: URL?) {
        
        guard let imageURL = url else { return }
        disposable = imageFetcher.fetchImage(imageURL).observe(on: UIScheduler()).startWithResult {[weak self] result in
            switch result {
            case .success(let image):
                self?.bookImage.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
}
