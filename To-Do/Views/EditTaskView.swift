import SwiftUI

struct EditTaskView: View {
    
    let task : Task
    
    @State private var name : String
    
    @Environment(\.dismiss)
    private var dismiss
    
    init(task: Task) {
        self.task = task
        _name = State(initialValue: task.name)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Task title", text: $name)
            }
            .navigationTitle("Edit Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                    }
                }
            }
        }
    }
    
    private func save() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty else {
            return
        }
        
        task.name = trimmedName
        
        dismiss()
    }
}

#Preview {
    EditTaskView(task: Task(name: "Test", isCompleted: false))
}
