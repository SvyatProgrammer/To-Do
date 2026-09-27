import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var searchText = ""
    @State private var selectedFilter : TaskFilter = .all
    @State private var isShowingAddTask = false
    
    @Environment(\.modelContext)
    private var modelContext
    
    @Query(
        sort: [
            SortDescriptor(
                \Task.createdAt, order: .reverse
            )
        ]
    )
    private var tasks: [Task]
    
    private var allTasksCount : Int {
        tasks.count
    }
    
    private var completedTasksCount : Int {
        tasks.filter {
            task in task.isCompleted
        }.count
    }
    
    private var activeTasksCount : Int {
        allTasksCount - completedTasksCount
    }
    
    var filterTasks : [Task] {
        switch selectedFilter {
        case .all:
            return tasks

        case .active:
            return tasks.filter { task in
                !task.isCompleted
            }

        case .completed:
            return tasks.filter { task in
                task.isCompleted
            }
        }
    }
    
    var filteredTasks: [Task] {
        let query = searchText
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !query.isEmpty else {
            return filterTasks
        }
        
        return filterTasks.filter { task in
            task.name.localizedCaseInsensitiveContains(query)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TaskStatsView(total: allTasksCount, active: activeTasksCount, completed: completedTasksCount)
                    .padding(.horizontal)
                    .padding(.top)
                
                TextField("Search tasks...", text: $searchText)
                    .textFieldStyle(.plain)
                    .padding()
                
                HStack {
                    FilterButton(title: "All", isSelected: selectedFilter == .all) {
                        selectedFilter = .all
                    }
                    FilterButton(title: "Active", isSelected: selectedFilter == .active) {
                        selectedFilter = .active
                    }
                    FilterButton(title: "Completed", isSelected: selectedFilter == .completed) {
                        selectedFilter = .completed
                    }
                }
                .padding(.bottom)
                
                if filterTasks.isEmpty {
                    if tasks.isEmpty {
                        ContentUnavailableView(
                            "No Tasks",
                            systemImage: "checklist",
                            description:
                                Text("Create your first task to get started.")
                        )
                    } else {
                        ContentUnavailableView(
                            "No results",
                            systemImage: "magnifyingglass",
                            description:
                                Text("Try another search.")
                        )
                    }
                } else {
                    List {
                        ForEach(filteredTasks) { task in
                            TaskRow(task: task)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                modelContext.delete(filteredTasks[index])
                            }
                        }
                    }
                }
            }
            .navigationTitle("My tasks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddTask = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddTask) {
                AddTaskView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self, inMemory: true)
}
