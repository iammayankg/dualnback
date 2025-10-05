import Foundation
import Combine

protocol GameViewModel: ObservableObject {
    associatedtype GameState

    var gameState: GameState { get }
    var score: Int { get }

    func startGame()
    func pauseGame()
    func resumeGame()
    func endGame()
}