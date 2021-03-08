//
//  TaskServiceProvider.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import Foundation

protocol TaskServiceProviderType: class {
    var dbService: TaskDatabaseServiceType { get }
    var taskService: TaskServiceType { get }
}

final class TaskServiceProvider: TaskServiceProviderType {
    lazy var dbService: TaskDatabaseServiceType = TaskDatabaseService(provider: self)
    lazy var taskService: TaskServiceType = TaskService(provider: self)
}
