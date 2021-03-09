//
//  TaskListCoordinator.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import UIKit

class TaskListCoordinator: Coordinator {
    
    var navigateToDetail: (TaskModel) -> Void = {_ in}
    var navigateToCreate: () -> Void = { }

    let navigationController: UINavigationController

    private static let storyboardName: String = "Task"
    private let serviceProvider: TaskServiceProviderType
    private let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)

    lazy var rootViewController: TaskListVC = {
        if let lvc = self.storyBoard.instantiateViewController(
            withIdentifier: TaskListVC.className
        ) as? TaskListVC {
            return lvc
        } else {
            return TaskListVC()
        }
    }()

    private lazy var viewModel: TaskListVM = {
        let viewModel = TaskListVM(serviceProvider: serviceProvider)
        return viewModel
    }()

    init(
        serviceProvider: TaskServiceProviderType,
        navigationController: UINavigationController
    ) {
        self.serviceProvider = serviceProvider
        self.navigationController = navigationController
    }

    @objc public override func start() {
        rootViewController.viewModel = viewModel
        
        viewModel.navigateToCreate = { [weak self] () in
            DispatchQueue.main.async {
                self?.navigateToCreate()
            }
        }
        
        viewModel.navigateToDetail = { [weak self] (model) in
            DispatchQueue.main.async {
                self?.navigateToDetail(model)
            }
        }
        
        navigationController.pushViewController(rootViewController, animated: true)
    }

    @objc public override func finish() {
        //TODO
    }
}
