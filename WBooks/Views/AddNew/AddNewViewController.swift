//
//  AddNewViewController.swift
//  WBooks
//
//  Created by Diego Quirós on 3/16/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    private lazy var _view: AddNewView = AddNewView.loadFromNib()!

    override func loadView() {
        view = _view
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _view.configureButton()
    }
    
    override func viewDidLoad() {
        navigationItem.title = "ADD NEW"
        super.viewDidLoad()
        
        _view.configureView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        _view.imageButton.addGestureRecognizer(tap)
        
        _view.imageButton.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "select source", message: "",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { action in
            switch action.style {
            case .default:
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .photoLibrary;
                    imagePicker.allowsEditing = true
                    self.present(imagePicker, animated: true, completion: nil)
                }
                
            case .cancel:
                break
                
            case .destructive:
                break
            }
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            switch action.style {
            case .default:
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    var imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .camera;
                    imagePicker.allowsEditing = false
                    self.present(imagePicker, animated: true, completion: nil)
                }
            case .cancel:
                break
                
            case .destructive:
                break
            }
        }))
        self.present(alert, animated: true, completion: nil)
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            var imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = .photoLibrary;
//            imagePicker.allowsEditing = true
//            self.present(imagePicker, animated: true, completion: nil)
//        }
        
    }
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //swiftlint:disable:next force_cast
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        _view.bookImage.image = image
        dismiss(animated:true, completion: nil)
    }

}
