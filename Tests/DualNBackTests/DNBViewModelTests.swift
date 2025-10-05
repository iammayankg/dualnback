import XCTest
@testable import DualNBack

class DNBViewModelTests: XCTestCase {

    var viewModel: DNBViewModel!

    override func setUp() {
        super.setUp()
        // Use custom settings for predictable testing. n=1 for most tests.
        let settings = DNBSettings(nBack: 1, sessionDuration: 60)
        viewModel = DNBViewModel(settings: settings)
        viewModel.startGame() // Start the game to initialize state
        viewModel.pauseGame() // Pause timer to manually control stimuli
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialState() {
        // Assert state after startGame() and pauseGame() in setUp
        XCTAssertEqual(viewModel.gameState.level, 1)
        XCTAssertEqual(viewModel.gameState.score, 0)
        XCTAssertTrue(viewModel.gameState.stimulusHistory.isEmpty)
        XCTAssertEqual(viewModel.gameState.currentStimulusIndex, -1)
        XCTAssertFalse(viewModel.isGameOver)
        XCTAssertFalse(viewModel.gameState.isGameActive, "Game should be paused by setUp")
    }

    func testCorrectPositionMatch() {
        // Arrange: n-back is 1. Create two stimuli where position matches.
        viewModel.gameState.stimulusHistory = [
            DNBStimulus(position: 3, sound: "A"),
            DNBStimulus(position: 3, sound: "B")
        ]
        viewModel.gameState.currentStimulusIndex = 1

        // Act
        viewModel.recordPositionMatch()

        // Assert
        XCTAssertEqual(viewModel.gameState.score, 1)
        XCTAssertEqual(viewModel.gameState.feedback, .correct)
    }

    func testIncorrectPositionMatch() {
        // Arrange: n-back is 1. Position does not match.
        viewModel.gameState.stimulusHistory = [
            DNBStimulus(position: 3, sound: "A"),
            DNBStimulus(position: 5, sound: "B")
        ]
        viewModel.gameState.currentStimulusIndex = 1

        // Act
        viewModel.recordPositionMatch()

        // Assert
        XCTAssertEqual(viewModel.gameState.score, -1)
        XCTAssertEqual(viewModel.gameState.feedback, .incorrect)
    }

    func testCorrectSoundMatch() {
        // Arrange: n-back is 1. Sound matches.
        viewModel.gameState.stimulusHistory = [
            DNBStimulus(position: 3, sound: "A"),
            DNBStimulus(position: 5, sound: "A")
        ]
        viewModel.gameState.currentStimulusIndex = 1

        // Act
        viewModel.recordSoundMatch()

        // Assert
        XCTAssertEqual(viewModel.gameState.score, 1)
        XCTAssertEqual(viewModel.gameState.feedback, .correct)
    }

    func testIncorrectSoundMatch() {
        // Arrange: n-back is 1. Sound does not match.
        viewModel.gameState.stimulusHistory = [
            DNBStimulus(position: 3, sound: "A"),
            DNBStimulus(position: 5, sound: "B")
        ]
        viewModel.gameState.currentStimulusIndex = 1

        // Act
        viewModel.recordSoundMatch()

        // Assert
        XCTAssertEqual(viewModel.gameState.score, -1)
        XCTAssertEqual(viewModel.gameState.feedback, .incorrect)
    }

    func testMatchAttempt_NotEnoughHistory() {
        // Arrange: n-back is 2, but only one stimulus exists.
        let settings = DNBSettings(nBack: 2)
        viewModel = DNBViewModel(settings: settings)
        viewModel.startGame()
        viewModel.pauseGame()

        viewModel.gameState.stimulusHistory = [
            DNBStimulus(position: 3, sound: "A")
        ]
        viewModel.gameState.currentStimulusIndex = 0
        let initialScore = viewModel.gameState.score

        // Act
        viewModel.recordPositionMatch()

        // Assert: Score should not change, feedback is incorrect.
        XCTAssertEqual(viewModel.gameState.score, initialScore)
        XCTAssertEqual(viewModel.gameState.feedback, .incorrect)
    }

    func testLevelUp() {
        // Arrange
        viewModel.gameState.score = 9
        viewModel.gameState.level = 1

        // Arrange a correct match to trigger level up
        viewModel.gameState.stimulusHistory = [
            DNBStimulus(position: 1, sound: "C"),
            DNBStimulus(position: 1, sound: "D")
        ]
        viewModel.gameState.currentStimulusIndex = 1

        // Act
        viewModel.recordPositionMatch() // This increments score to 10 and should trigger levelUp

        // Assert: levelUp() calls startGame(), which resets state for the new level.
        XCTAssertEqual(viewModel.gameState.level, 2, "The game should level up to n=2")
        XCTAssertEqual(viewModel.gameState.score, 0, "Score should reset on level up")
        XCTAssertFalse(viewModel.isGameOver, "Game should not be over after leveling up")
    }

    func testEndGame() {
        // Arrange
        viewModel.startGame()
        XCTAssertFalse(viewModel.isGameOver)

        // Act
        viewModel.endGame()

        // Assert
        XCTAssertTrue(viewModel.isGameOver)
        XCTAssertFalse(viewModel.gameState.isGameActive)
    }
}