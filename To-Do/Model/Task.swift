import Foundation
import SwiftData

@Model
final class Task {
    var name : String
    var isCompleted : Bool
    var createdAt : Date
    
    init(name: String, isCompleted: Bool = false) {
        self.name = name
        self.isCompleted = isCompleted
        self.createdAt = Date()
    }
}
