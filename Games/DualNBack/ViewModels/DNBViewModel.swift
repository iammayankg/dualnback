import Foundation
import Combine

class DNBViewModel: GameViewModel {
    typealias GameState = DNBGameState

    @Published var gameState: DNBGameState
    private var settings: DNBSettings
    private var timer: AnyCancellable?

    var score: Int {
        return gameState.score
    }

    init(settings: DNBSettings = DNBSettings()) {
        self.settings = settings
        self.gameState = DNBGameState()
    }

    func startGame() {
        gameState = DNBGameState(level: settings.nBack)
        gameState.isGameActive = true
        // Placeholder for stimulus generation and timer
        print("Starting Dual-N-Back game with n = \(settings.nBack)")
    }

    func pauseGame() {
        gameState.isGameActive = false
        timer?.cancel()
        print("Game paused")
    }

    func resumeGame() {
        gameState.isGameActive = true
        // Placeholder for resuming timer
        print("Game resumed")
    }

    func endGame() {
        gameState.isGameActive = false
        timer?.cancel()
        print("Game ended. Final score: \(score)")
    }

    // MARK: - Game-specific actions

    func recordPositionMatch() {
        // Placeholder for position match logic
        print("Position match recorded")
    }

    func recordSoundMatch() {
        // Placeholder for sound match logic
        print("Sound match recorded")
    }
}