//
//  TaskDatabaseService.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import Foundation

protocol TaskDatabaseServiceType {

    func populateTasks() -> [TaskModel]
}

final class TaskDatabaseService: TaskBaseService, TaskDatabaseServiceType {
    
    func populateTasks() -> [TaskModel] {
        return getSamples([TaskModel].self, fromJSONPath: "sampletask")
    }
}
