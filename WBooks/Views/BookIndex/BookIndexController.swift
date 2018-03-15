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
    private let _viewModel: BookIndexViewModel
    
    init(bookIndexViewModel: BookIndexViewModel) {
        _viewModel = bookIndexViewModel
        
        super.init(nibName: nil, bundle: nil)
        
        bindViewModel()
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
    }
    
}

extension BookIndexController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: BookIndexCell.self, for: indexPath)!
        cell.configureCell(for: _viewModel[indexPath.row])
        return cell
    }
    
}

// MARK: - Private Methods
private extension BookIndexController {
    
    func bindViewModel() {
        _viewModel.bookViewModels.signal.observeValues { [unowned self] _ in
            self._view.tableView.reloadData()
        }
    }
    
    func configureTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
        _view.tableView.register(cell: BookIndexCell.self)
  //      _view.tableView.rowHeight = BookIndexCell.Height
        _view.configureView()
    }

}
