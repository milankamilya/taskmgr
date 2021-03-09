//
//  TaskBaseService.swift
//  TaskManager
//
//  Created by Milan Kamilya on 08/03/21.
//

import Foundation

class TaskBaseService {

    unowned let provider: TaskServiceProviderType
    
    init(provider: TaskServiceProviderType) {
        self.provider = provider
    }
    
    public func getSamples<T:Decodable>(_:T.Type, fromJSONPath path:String) -> T {
        let path = Bundle.main.path(forResource: path, ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        let result = try? JSONDecoder().decode(T.self, from: data!)
        return result!
    }
}
