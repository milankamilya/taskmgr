//
//  TaskDetailCoordinator.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import UIKit

class TaskDetailCoordinator: Coordinator {
    let navigationController: UINavigationController

    private static let storyboardName: String = "Task"
    private let serviceProvider: TaskServiceProviderType
    private let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)

    lazy var rootViewController: TaskDetailVC = {
        if let lvc = self.storyBoard.instantiateViewController(
            withIdentifier: TaskDetailVC.className
        ) as? TaskDetailVC {
            return lvc
        } else {
            return TaskDetailVC()
        }
    }()

    private lazy var viewModel: TaskDetailVM = {
        let viewModel = TaskDetailVM(serviceProvider: serviceProvider)
        return viewModel
    }()

    init(
        serviceProvider: TaskServiceProviderType,
        navigationController: UINavigationController,
        model: TaskModel?
    ) {
        self.serviceProvider = serviceProvider
        self.navigationController = navigationController
        super.init()
        viewModel.task = model
    }

    @objc public override func start() {
        rootViewController.viewModel = viewModel
        navigationController.pushViewController(rootViewController, animated: true)
    }

    @objc public override func finish() {
        //TODO
    }
}
