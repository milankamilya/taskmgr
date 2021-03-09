//
//  TaskCell.swift
//  TaskManager
//
//  Created by Milan Kamilya on 09/03/21.
//

import UIKit

class TaskCell: ReusableTableViewCell {

    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var statusContainer: UIView!
    @IBOutlet weak var statusLB: UILabel!
    
    private var viewModel: TaskCellVM!

    func prepareCell(viewModel: TaskCellVM) {
        self.viewModel = viewModel
        setupUI()
    }
    
    func setupUI() {
        titleLB.text = viewModel.title
        statusLB.text = viewModel.status
        statusContainer.backgroundColor = viewModel.statusColor
    }
}
