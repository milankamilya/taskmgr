//
//  TaskModel.swift
//  TaskManager
//
//  Created by Milan Kamilya on 09/03/21.
//

import Foundation

// MARK: - TaskModel
struct TaskModel: Codable, Comparable, Hashable {
    var title, desc: String?
    var dueDate: String?
    var shouldSync: Bool?
    var status: String?

    enum CodingKeys: String, CodingKey {
        case title
        case desc
        case dueDate, shouldSync, status
    }
    
    let id: String
    
    public init() {
        id = UUID().uuidString
    }
    
    public init(from decoder: Decoder) throws {
        
        id = UUID().uuidString
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        desc = try container.decodeIfPresent(String.self, forKey: .desc)
        dueDate = try container.decodeIfPresent(String.self, forKey: .dueDate)
        shouldSync = try container.decodeIfPresent(Bool.self, forKey: .shouldSync)
        status = try container.decodeIfPresent(String.self, forKey: .status)

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
