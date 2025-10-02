import SwiftUI

struct DNBGameView: GameView {
    typealias ViewModel = DNBViewModel

    @ObservedObject var viewModel: DNBViewModel

    var body: some View {
        ZStack {
            VStack {
                // Header
                HStack {
                    Text("Level: \(viewModel.gameState.level)")
                    Spacer()
                    Text("Score: \(viewModel.score)")
                }
                .font(.headline)
                .padding()

                // Game Grid
                DNBGridView(highlightedCell: viewModel.gameState.currentStimulusIndex >= 0 ? viewModel.gameState.stimulusHistory[viewModel.gameState.currentStimulusIndex].position : nil)
                    .padding()

                // Action Buttons
                HStack(spacing: 20) {
                    Button(action: viewModel.recordPositionMatch) {
                        Text("Position Match")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    Button(action: viewModel.recordSoundMatch) {
                        Text("Sound Match")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.bottom)

                // Game Controls
                HStack {
                    Button(viewModel.gameState.isGameActive ? "Pause" : "Resume", action: {
                        if viewModel.gameState.isGameActive {
                            viewModel.pauseGame()
                        } else {
                            viewModel.resumeGame()
                        }
                    })
                    Spacer()
                    Button("End Game", action: viewModel.endGame)
                        .foregroundColor(.red)
                }
                .padding()
            }

            // Visual Feedback Overlay
            viewModel.gameState.feedback.color
                .opacity(0.4)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.2), value: viewModel.gameState.feedback)
        }
        .onAppear(perform: viewModel.startGame)
    }
}