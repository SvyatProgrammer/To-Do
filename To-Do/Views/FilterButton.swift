import SwiftUI

struct FilterButton: View {
    
    let title : String
    let isSelected : Bool
    let action : () -> Void
    
    var body: some View {
        Button(title) {
            action()
        }
        .font(.subheadline)
        .fontWeight(.semibold)
        .foregroundStyle(isSelected ? .blue : .primary)
        .buttonStyle(.glass)
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
    }
}

#Preview {
    FilterButton(title: "All", isSelected: true) {
        print("NaN")
    }
}
