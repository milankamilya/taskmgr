//
//  BaseViewController.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Public Properties
    var viewModel: BaseViewModel?

    deinit {
        //Log.info("\(type(of: self)) destroyed")
    }

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
