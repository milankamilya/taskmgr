//
//  TaskListVC.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import UIKit

class TaskListVC: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 100.0
            tableView.sectionHeaderHeight = 60.0
            tableView.sectionFooterHeight = 0.0
            tableView.separatorStyle = .none
            tableView.tableFooterView = UIView(frame: .zero)

            TaskCell.registerWithTable(tableView)
            TaskHeaderView.registerWithTable(tableView)
        }
    }

    let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)

    
    // MARK: - Public Properties
    override var viewModel: BaseViewModel? {
        get { return pvtViewModel }
        set {
            if let newValue =  newValue as? TaskListVM {
                pvtViewModel = newValue
            } else { preconditionFailure("Please send proper ViewModel object") }
        }
    }

    // MARK: - File Private Properties
    fileprivate var pvtViewModel: TaskListVM!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        pvtViewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pvtViewModel?.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pvtViewModel?.viewWillDisappear()
    }

    // MARK: - Initial Setup
    func initialSetup() {
        navigationItem.rightBarButtonItem = self.addButtonItem
        navigationItem.title = "Tasks"
     
        pvtViewModel?.reloadTableUI = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Customize View
    // MARK: - IBActions
    // MARK: - Utility

}

// MARK: - Table View Delegate
extension TaskListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pvtViewModel?.cellSelected(forIndex: indexPath)
    }

}

// MARK: - Table View Datasource
extension TaskListVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return pvtViewModel?.numberOfSections ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerType = pvtViewModel?.sectionType(forIndex: section) {
            switch headerType {
            case .simple(let model):
                return headerForSimpleHeader(tableView, section: section, viewModel: model)
            case .noDataFound:
                return UIView(frame: .zero)
            }
        } else {
            return UIView(frame: .zero)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pvtViewModel?.numberOfCells(inSection: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellType = pvtViewModel?.cellType(forIndex: indexPath) {
            switch cellType {
            case .simple(let model):
                return cellForSimpleCell(tableView, indexPath: indexPath, viewModel: model)
            case .noDataFound:
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }

    }

    private func cellForSimpleCell(_ tableView: UITableView,
                                   indexPath: IndexPath,
                                   viewModel: TaskCellVM) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TaskCell.reuseIdentifier,
            for: indexPath)
            as? TaskCell
            else { return UITableViewCell() }

        cell.selectionStyle = .none
        cell.prepareCell(viewModel: viewModel)
        return cell
    }

    private func headerForSimpleHeader(_ tableView: UITableView,
                                       section: Int,
                                       viewModel: TaskHeaderVM) -> UIView {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TaskHeaderView.reuseIdentifier)
            as? TaskHeaderView
            else { return UITableViewCell() }

        cell.selectionStyle = .none
        cell.prepareHeader(viewModel: viewModel)
        return cell
    }
}
