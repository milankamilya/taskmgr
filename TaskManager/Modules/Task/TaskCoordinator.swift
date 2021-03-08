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
        navigateToEmpDocDashboard()
    }
    
    public override func finish() {
        // TODO: Release all instances
    }

    private func navigateToEmpDocDashboard() {
        listCoordinator = getTaskListCoordinator()
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

}
