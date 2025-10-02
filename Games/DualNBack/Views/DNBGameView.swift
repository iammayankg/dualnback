import SwiftUI

struct DNBGameView: GameView {
    typealias ViewModel = DNBViewModel

    @ObservedObject var viewModel: DNBViewModel

    var body: some View {
        VStack {
            Text("Dual-N-Back")
                .font(.largeTitle)

            Text("Level: \(viewModel.gameState.level)")
                .font(.title)

            Text("Score: \(viewModel.score)")
                .font(.title)

            // Placeholder for the game grid
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 300, height: 300)
                .overlay(Text("Game Grid").foregroundColor(.gray))

            HStack(spacing: 20) {
                Button("Position Match", action: viewModel.recordPositionMatch)
                Button("Sound Match", action: viewModel.recordSoundMatch)
            }
            .padding()

            HStack {
                Button("Pause", action: viewModel.pauseGame)
                Button("Resume", action: viewModel.resumeGame)
                Button("End Game", action: viewModel.endGame)
            }
            .padding()
        }
        .onAppear(perform: viewModel.startGame)
    }
}