//
//  TaskHeaderView.swift
//  TaskManager
//
//  Created by Milan Kamilya on 09/03/21.
//

import UIKit

class TaskHeaderView: ReusableTableViewCell {

    @IBOutlet weak var dateLB: UILabel!

    private var viewModel: TaskHeaderVM!

    func prepareHeader(viewModel: TaskHeaderVM) {
        self.viewModel = viewModel
        setupUI()
    }

    func setupUI() {
        dateLB.text = viewModel.date
    }
}
