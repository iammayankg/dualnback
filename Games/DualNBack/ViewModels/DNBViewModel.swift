import Foundation
import Combine
import AVFoundation

class DNBViewModel: GameViewModel {
    typealias GameState = DNBGameState

    @Published var gameState: DNBGameState
    @Published var isGameOver: Bool
    private var settings: DNBSettings
    private var timer: AnyCancellable?
    private let audioService = AudioService()

    private let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { $0 }
    private let gridSize = 9 // 3x3 grid

    var score: Int {
        return gameState.score
    }

    init(settings: DNBSettings = DNBSettings()) {
        self.settings = settings
        self.gameState = DNBGameState()
        self.isGameOver = true
    }

    func startGame() {
        isGameOver = false
        gameState = DNBGameState(level: settings.nBack)
        gameState.isGameActive = true
        gameState.stimulusHistory = []
        gameState.currentStimulusIndex = -1
        gameState.score = 0

        resumeGame()
    }

    func pauseGame() {
        gameState.isGameActive = false
        timer?.cancel()
    }

    func resumeGame() {
        guard !isGameOver else { return }
        gameState.isGameActive = true
        timer = Timer.publish(every: 3.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.nextStimulus()
            }
    }

    func endGame() {
        isGameOver = true
        gameState.isGameActive = false
        timer?.cancel()
    }

    private func nextStimulus() {
        // Generate new stimulus
        let newPosition = Int.random(in: 0..<gridSize)
        let newSound = letters.randomElement()!
        let newStimulus = DNBStimulus(position: newPosition, sound: newSound)

        // Update state
        gameState.stimulusHistory.append(newStimulus)
        gameState.currentStimulusIndex += 1

        // Play sound
        audioService.speak(letter: newStimulus.sound)

        // Reset feedback after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.gameState.feedback = .none
        }
    }

    private func checkForMatch(isPositionMatch: Bool) {
        guard gameState.isGameActive else { return }

        let n = gameState.level
        let currentIndex = gameState.currentStimulusIndex

        guard currentIndex >= n else {
            // Not enough history for a match
            gameState.feedback = .incorrect
            return
        }

        let currentStimulus = gameState.stimulusHistory[currentIndex]
        let nBackStimulus = gameState.stimulusHistory[currentIndex - n]

        var isCorrect = false
        if isPositionMatch {
            isCorrect = currentStimulus.position == nBackStimulus.position
        } else {
            isCorrect = currentStimulus.sound == nBackStimulus.sound
        }

        if isCorrect {
            gameState.score += 1
            gameState.feedback = .correct
        } else {
            gameState.score -= 1
            gameState.feedback = .incorrect
        }

        // Level up logic (simple version)
        if gameState.score > 0 && gameState.score % 10 == 0 {
            levelUp()
        }
    }

    private func levelUp() {
        settings.nBack += 1
        // Restart the game at the new level
        startGame()
    }

    // MARK: - Game-specific actions

    func recordPositionMatch() {
        checkForMatch(isPositionMatch: true)
    }

    func recordSoundMatch() {
        checkForMatch(isPositionMatch: false)
    }
}