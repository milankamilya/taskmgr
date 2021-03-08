//
//  TaskListCoordinator.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import UIKit

class TaskListCoordinator: Coordinator {
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
        navigationController.pushViewController(rootViewController, animated: true)
    }

    @objc public override func finish() {
        //TODO
    }
}
