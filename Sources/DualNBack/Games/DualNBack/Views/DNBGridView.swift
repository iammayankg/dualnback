import SwiftUI

struct DNBGridView: View {
    let gridSize = 3
    let highlightedCell: Int?

    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize)) {
                ForEach(0..<gridSize * gridSize, id: \.self) { index in
                    Rectangle()
                        .fill(index == highlightedCell ? Color.blue : Color.gray.opacity(0.3))
                        .frame(height: 80)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
}

struct DNBGridView_Previews: PreviewProvider {
    static var previews: some View {
        DNBGridView(highlightedCell: 4)
    }
}