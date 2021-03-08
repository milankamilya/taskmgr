//
//  TaskListVM.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import Foundation

class TaskListVM: BaseViewModel {
    
    // MARK: - Public Properties
    // MARK: - Public Closures
    // MARK: - Private Property
    private let serviceProvider: TaskServiceProviderType

    // MARK: - Init
    init(serviceProvider: TaskServiceProviderType ) {
        self.serviceProvider = serviceProvider
    }
    // MARK: - Init
    // MARK: - Lifecycle Methods
    func viewDidLoad() {
        
    }

    func viewWillAppear() {
        
    }

    func viewWillDisappear() {
        
    }
    // MARK: - Server API Call
    // MARK: - Data Processing
    // MARK: - Process TableView Data
}
