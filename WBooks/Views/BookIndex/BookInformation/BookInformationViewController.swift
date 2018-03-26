//
//  BookInformationViewController.swift
//  WBooks
//
//  Created by Diego Quirós on 3/19/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import Core
import ReactiveSwift
import enum Result.NoError

class BookInformationViewController: UIViewController {
    
    private lazy var _view: BookInformationView = BookInformationView.loadFromNib()!
    
    var bookViewModel: BookViewModel
    var bookInformationViewModel: BookInformationViewModel

    init(bookViewModel viewModel: BookViewModel) {
        self.bookViewModel = viewModel
        self.bookInformationViewModel = BookInformationViewModel(bookID: viewModel.id)
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        navigationItem.title = "BOOK DETAIL"
        super.viewDidLoad()
        configureTableView()
        _view.configureBookInformation()
        bookInformationViewModel.getComments()
        bookInformationViewModel.getRents()
        
    }

    override func loadView() {
        view = _view
    }

}

extension BookInformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookInformationViewModel.count > 5 {
            return 5
        } else {
            return bookInformationViewModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: BookCommentsCellView.self, for: indexPath)!
        cell.configureCell(comment: bookInformationViewModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell: BookInformationCellView = BookInformationCellView.loadFromNib()!
        cell.configureCell(for: bookViewModel, isAvailable: bookInformationViewModel.isAvailable())
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
}

private extension BookInformationViewController {
    func configureTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
        _view.tableView.register(cell: BookCommentsCellView.self)
        _view.tableView.separatorStyle = .none
        _view.configureBookInformation()
    }
}

private extension BookInformationViewController {
    
    func bindViewModel() {
        bookInformationViewModel.comments.signal.observeValues { [unowned self] _ in
            self._view.tableView.reloadData()
        }
        bookInformationViewModel.rents.signal.observeValues { [unowned self] _ in
            self._view.tableView.reloadData()
        }
    }
}
