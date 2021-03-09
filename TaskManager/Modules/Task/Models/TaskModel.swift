//
//  TaskModel.swift
//  TaskManager
//
//  Created by Milan Kamilya on 09/03/21.
//

import Foundation

// MARK: - TaskModel
struct TaskModel: Codable, Comparable, Hashable {
    let id: String?
    let title, desc: String?
    let dueDate: Date?
    let shouldSync: Bool?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case desc
        case dueDate, shouldSync, status
    }
    
    public static func == (lhs: TaskModel, rhs: TaskModel) -> Bool {
        return lhs.id == rhs.id
    }

    public static func > (lhs: TaskModel, rhs: TaskModel) -> Bool {
        guard let lhsDueDate = lhs.dueDate,
           let rhsDueDate = rhs.dueDate else {
            return false
        }

        return lhsDueDate > rhsDueDate
    }

    public static func < (lhs: TaskModel, rhs: TaskModel) -> Bool {
        guard let lhsDueDate = lhs.dueDate,
           let rhsDueDate = rhs.dueDate else {
            return false
        }

        return lhsDueDate < rhsDueDate
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(dueDate?.description ?? "")
    }
}
