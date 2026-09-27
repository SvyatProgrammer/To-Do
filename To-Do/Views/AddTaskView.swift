import SwiftUI
import SwiftData

struct AddTaskView: View {
    
    @Environment(\.modelContext)
    private var modelContext
    
    @Environment(\.dismiss)
    private var dismiss
    
    @State private var name = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Task name", text: $name)
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addTask()
                    }
                    .disabled(
                        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    )
                }
            }
        }
    }
    
    private func addTask() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty else {
            return
        }
        
        let task = Task(name: trimmedName)
        
        modelContext.insert(task)
        
        dismiss()
    }
}

#Preview {
    AddTaskView()
}
