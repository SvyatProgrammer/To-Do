import SwiftUI

struct TaskRow: View {
    
    let task : Task
    
    @State private var isEditing = false
    
    var body: some View {
        Button {
            task.isCompleted.toggle()
        } label: {
            HStack {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                VStack(alignment: .leading, spacing: 3) {
                    Text(task.name)
                        .strikethrough(task.isCompleted)
                        .foregroundStyle(task.isCompleted ? .secondary : .primary)
                    
                    Text(task.createdAt, format: .dateTime.day().month(.wide).hour().minute())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                
                Menu {
                    Button("Edit") {
                        isEditing = true
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .padding(.horizontal, 8)
                }
            }
            .buttonStyle(.plain)
        }
        .animation(.default, value: task.isCompleted)
        .sheet(isPresented: $isEditing) {
            EditTaskView(task: task)    
        }
        
    }
}


#Preview {
    TaskRow(task: Task(name: "Test", isCompleted: false))
}
