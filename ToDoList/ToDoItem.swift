//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Bekir Berke Yılmaz on 28.09.2023.
//

import Foundation
import SwiftData

@Model
final class ToDoItem{
    var title: String
    var userDescription: String
    var isCompleted: Bool
    init(title: String, description: String, isCompleted: Bool) {
        self.title = title
        self.userDescription = description
        self.isCompleted = isCompleted
    }
}
extension ToDoItem{
    static let sampleData: ToDoItem = ToDoItem(title: "Hello", description: "World", isCompleted: false)
}
