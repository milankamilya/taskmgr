//
//  TaskCellVM.swift
//  TaskManager
//
//  Created by Milan Kamilya on 09/03/21.
//

import UIKit

class TaskCellVM {
    var title: String?
    var status: String?
    
    var statusColor: UIColor?

    var model: TaskModel!

    init(model: TaskModel) {
        self.model = model
        configureOutput()
    }

    /// It manipulate/configure data from RoomStatusModel for displaying them on table cell
    func configureOutput() {
        title = model.title
        status = model.status
    }
}
