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
}
