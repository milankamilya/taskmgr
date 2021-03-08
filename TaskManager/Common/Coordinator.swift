//
//  Coordinator.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import UIKit

public class Coordinator: NSObject {

    var readyToFinish: () -> Void = {}

    private(set) var childCoordinators: [Coordinator] = []

    deinit {
        print("\(type(of: self)) destroyed")
    }

    public func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    public func finish() {
        //preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: {$0 === coordinator}) {
            childCoordinators.remove(at: index)
        }
    }

    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }

    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }

    func findChildCoordinatorWith<T>(type: T.Type) -> Coordinator? {
        return childCoordinators.filter { $0 is T  == true }.first
    }

    func showViewController(_ viewController: UIViewController,
                            from: UIViewController, animated: Bool) {
        if from is UINavigationController,
           let navViewController = from as? UINavigationController {
            navViewController.pushViewController(viewController, animated: animated)
        } else {
            from.present(viewController, animated: animated, completion: nil)
        }
    }
}
