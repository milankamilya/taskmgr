//
//  TaskCoordinator.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import UIKit

class TaskCoordinator: Coordinator {
    let navigationController: UINavigationController

    private let serviceProvider: TaskServiceProviderType

    private var listCoordinator: TaskListCoordinator?
    private var detailCoordinator: TaskDetailCoordinator?

    init(navigationController: UINavigationController) {
        serviceProvider = TaskServiceProvider()
        self.navigationController = navigationController
        super.init()
    }

    public override func start() {
        navigateToTaskList()
    }
    
    public override func finish() {
        // TODO: Release all instances
    }

    private func navigateToTaskList() {
        listCoordinator = getTaskListCoordinator()
        listCoordinator?.navigateToCreate = { [weak self] () in
            DispatchQueue.main.async {
                self?.navigateToTaskDetail(model: nil)
            }
        }
        
        listCoordinator?.navigateToDetail = { [weak self] (model) in
            DispatchQueue.main.async {
                self?.navigateToTaskDetail(model: model)
            }
        }
        listCoordinator?.start()
    }

    private func getTaskListCoordinator() -> TaskListCoordinator {
        let coordinator = TaskListCoordinator(
            serviceProvider: serviceProvider,
            navigationController: navigationController
        )

        coordinator.readyToFinish = { [weak self, weak coordinator] in
            if let strongRef = coordinator {
                self?.removeChildCoordinator(strongRef)
                strongRef.finish()
            }
            self?.finish()
        }

        addChildCoordinator(coordinator)
        return coordinator
    }
    
    private func navigateToTaskDetail(model: TaskModel?) {
        detailCoordinator = getTaskDetailCoordinator(model: model)
        detailCoordinator?.start()
    }

    private func getTaskDetailCoordinator(model: TaskModel?) -> TaskDetailCoordinator {
        let coordinator = TaskDetailCoordinator(
            serviceProvider: serviceProvider,
            navigationController: navigationController,
            model: model
        )

        coordinator.readyToFinish = { [weak self, weak coordinator] in
            if let strongRef = coordinator {
                self?.removeChildCoordinator(strongRef)
                strongRef.finish()
            }
            self?.finish()
        }

        addChildCoordinator(coordinator)
        return coordinator
    }

}
