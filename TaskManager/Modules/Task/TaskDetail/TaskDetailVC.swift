//
//  TaskDetailVC.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import UIKit

class TaskDetailVC: BaseViewController {

    // MARK: - IBOutlets
    // MARK: - Public Properties
    override var viewModel: BaseViewModel? {
        get { return pvtViewModel }
        set {
            if let newValue =  newValue as? TaskDetailVM {
                pvtViewModel = newValue
            } else { preconditionFailure("Please send proper ViewModel object") }
        }
    }

    // MARK: - File Private Properties
    fileprivate var pvtViewModel: TaskDetailVM?

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pvtViewModel?.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pvtViewModel?.viewWillDisappear()
    }

    // MARK: - Initial Setup
    func initialSetup() {
        
    }

    // MARK: - Customize View
    // MARK: - IBActions
    @IBAction func onBack() {
    }

    // MARK: - Utility

}
