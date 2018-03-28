//
//  RentalsViewController.swift
//  WBooks
//
//  Created by Diego Quirós on 3/16/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class RentalsViewController: UIViewController {
    
    private let _view: BookIndexView = BookIndexView.loadFromNib()!
    let viewModel: RentalsViewModel = RentalsViewModel(bookRepository: RepositoryCreator.shared.bookRepository)
    
    override func loadView() {
        super.loadView()
        view = _view
    }
    
    override func viewDidLoad() {
        navigationItem.title = "RENTALS"
        super.viewDidLoad()
        configureTableView()
        viewModel.getRents()
        bindViewModel()
    }
    
    func configureTableView() {
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
        _view.tableView.register(cell: BookIndexCell.self)
        _view.tableView.separatorStyle = .none
        _view.configureView()
    }

}

extension RentalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BookIndexCell = tableView.dequeue(cell: BookIndexCell.self, for: indexPath)!
        cell.configureCell(for: viewModel[indexPath.row])
        return cell
    }
    
}
private extension RentalsViewController {
    
    func bindViewModel() {
        viewModel.bookViewModels.signal.observeValues { [unowned self] _ in
            self._view.tableView.reloadData()
        }
    }
}
