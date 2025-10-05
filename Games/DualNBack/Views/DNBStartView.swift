import SwiftUI

struct DNBStartView: View {
    @StateObject private var viewModel = DNBViewModel()

    var body: some View {
        VStack {
            if viewModel.isGameOver {
                Text("Dual-N-Back")
                    .font(.largeTitle)
                Button("Start Game") {
                    viewModel.startGame()
                }
                .padding()
            } else {
                DNBGameView(viewModel: viewModel)
            }
        }
    }
}

struct DNBStartView_Previews: PreviewProvider {
    static var previews: some View {
        DNBStartView()
    }
}