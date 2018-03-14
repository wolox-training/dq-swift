//
//  BookIndexController.swift
//  WBooks
//
//  Created by Diego Quirós on 3/12/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import Core

final internal class BookIndexController: UIViewController {
    
    private lazy var _view: BookIndexView = BookIndexView.loadFromNib()!
    private let _bookIndexViewModel: BookIndexViewModel
    
    init(bookIndexViewModel: BookIndexViewModel) {
        _bookIndexViewModel = bookIndexViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        _bookIndexViewModel.bookViewModels.producer.startWithValues {
            print($0)
            print($0)
        }
    }
    
}

extension BookIndexController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _bookIndexViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: BookIndexCell.self, for: indexPath)!
        cell.configureCell(for: _bookIndexViewModel[indexPath.row])
        return cell
    }
}

private extension BookIndexController {
    
    func configureTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
        _view.tableView.register(cell: BookIndexCell.self)
        _view.tableView.rowHeight = BookIndexCell.Height
        _view.configureView()
    }
}
