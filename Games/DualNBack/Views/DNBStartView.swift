import SwiftUI

struct DNBStartView: View {
    @State private var isGameActive = false

    var body: some View {
        VStack {
            if isGameActive {
                DNBGameView(viewModel: DNBViewModel())
            } else {
                Text("Dual-N-Back")
                    .font(.largeTitle)
                Button("Start Game") {
                    isGameActive = true
                }
                .padding()
            }
        }
    }
}

struct DNBStartView_Previews: PreviewProvider {
    static var previews: some View {
        DNBStartView()
    }
}