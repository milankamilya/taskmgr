//
//  TaskListVM.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import Foundation

enum TaskCellType {
    case simple(viewModel: TaskCellVM)
    case noDataFound
}

enum TaskHeaderType {
    case simple(model: TaskHeaderVM)
    case noDataFound
}

class TaskListVM: BaseViewModel {
    
    // MARK: - Public Properties
    var numberOfSections: Int = 0

    // MARK: - Public Closures
    var reloadTableUI: () -> Void = { }
    var navigateToDetail: (TaskModel) -> Void = {_ in}
    var navigateToCreate: () -> Void = { }

    // MARK: - Private Property
    private let serviceProvider: TaskServiceProviderType
    fileprivate var tasks: [TaskModel] = [TaskModel]() {
        didSet {
            prepareDataSource()
            reloadTableUI()
        }
    }
    fileprivate var dataSource: [String: [TaskCellType]] = [String: [TaskCellType]]()
    fileprivate var sectionDataSource: [TaskHeaderType] = [TaskHeaderType]()
    
    
    // MARK: - Init
    init(serviceProvider: TaskServiceProviderType) {
        self.serviceProvider = serviceProvider
    }

    // MARK: - Init
    // MARK: - Lifecycle Methods
    func viewDidLoad() {
        tasks = serviceProvider.dbService.populateTasks()
    }

    func viewWillAppear() {
        
    }

    func viewWillDisappear() {
        
    }
    // MARK: - Server API Call
    // MARK: - Data Processing
    private func getTasksSeparatedByDates(tasks: [TaskModel]) -> [String: [TaskCellType]] {

        var result = [String: [TaskCellType]]()

        var mappedSet = [String: Set<TaskModel>]()
        
        for task in tasks {
            let date = task.dueDate

            // This code will crash if fullname is empty
            let day = Date.getDate(fromString: date ?? "")?.toString(.EEEE_MM_dd) ?? "Without Due Date"

            var mutableOrderedSet = mappedSet[day] ?? Set<TaskModel>()
            mutableOrderedSet.insert(task)
            mappedSet[day] = mutableOrderedSet
        }

        for key in Array(mappedSet.keys) {
            guard let sortedItems = mappedSet[key]?.sorted(by: <) else { continue }
            result[key] = getCellTypes(tasks: sortedItems)
        }

        return result
    }
    
}

// MARK: - Process TableView Data
extension TaskListVM {

    private func prepareDataSource() {
        let localDataSource = getTasksSeparatedByDates(tasks: tasks)
        let sortedStrings = Array(localDataSource.keys).sorted(by: <)
        let localSectionDataSource = getHeaderTypes(letters: sortedStrings)

        dataSource = localDataSource
        sectionDataSource = localSectionDataSource
        numberOfSections = sectionDataSource.count
    }

    private func getCellTypes(tasks: [TaskModel]) -> [TaskCellType] {
        var cellTypes = [TaskCellType]()

        if tasks.count == 0 {
            cellTypes.append(TaskCellType.noDataFound)
            return cellTypes
        }

        for task in tasks {
            let cellVM = TaskCellVM(model: task)
            cellTypes.append(TaskCellType.simple(viewModel: cellVM))
        }

        return cellTypes
    }

    private func getHeaderTypes(letters: [String]) -> [TaskHeaderType] {
        var headerTypes = [TaskHeaderType]()

        if letters.isEmpty {
            headerTypes.append(.noDataFound)
        } else {
            headerTypes = letters.map { (date) -> TaskHeaderType in
                let headerVM = TaskHeaderVM(date: date)
                return .simple(model: headerVM)
            }
        }
        return headerTypes
    }

    func sectionType(forIndex section: Int) -> TaskHeaderType {
        return sectionDataSource[section]
    }

    func numberOfCells(inSection section: Int) -> Int {
        let String = sectionDataSource[section]
        switch String {
        case .simple(let model):
            return dataSource[model.date]?.count ?? 0
        case .noDataFound:
            return 1
        }
    }

    func cellType(forIndex indexPath: IndexPath) -> TaskCellType? {
        let String = sectionDataSource[indexPath.section]
        switch String {
        case .simple(let model):
            if let count = dataSource[model.date]?.count, count > indexPath.row {
                return dataSource[model.date]?[indexPath.row]
            } else {
                return nil
            }
        case .noDataFound:
            return .noDataFound
        }
    }

    func cellSelected(forIndex indexPath: IndexPath) {

        let String = sectionDataSource[indexPath.section]
        switch String {
        case .simple(let sectionViewModel):
            if
                let count = dataSource[sectionViewModel.date]?.count, count > indexPath.row,
                let cellViewModelType = dataSource[sectionViewModel.date]?[indexPath.row] {

                switch cellViewModelType {
                case .simple(let cellViewModel):
                    navigateToDetail(cellViewModel.model)
                default:
                    break
                }
            }
        default:
            break
        }

    }
}
