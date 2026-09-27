import SwiftUI

struct TaskStatsView: View {
    
    let total : Int
    let active : Int
    let completed : Int
    
    var body: some View {
        HStack {
            VStack {
                Text("\(total)")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Total")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack {
                Text("\(active)")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Active")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack {
                Text("\(completed)")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Completed")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.secondary.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    TaskStatsView(total: 10, active: 4, completed: 6)
}
