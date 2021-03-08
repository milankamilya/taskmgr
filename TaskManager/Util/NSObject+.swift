//
//  NSObject+.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import Foundation

protocol NameDescribable {
    var className: String { get }
    static var className: String { get }
}

extension NameDescribable {
    var className: String {
        return String(describing: type(of: self))
    }

    static var className: String {
        return String(describing: self)
    }
}

extension NSObject: NameDescribable {}
extension Array: NameDescribable {}
