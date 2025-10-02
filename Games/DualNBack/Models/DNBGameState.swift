import Foundation

struct DNBGameState {
    var level: Int = 1
    var score: Int = 0
    var stimuli: [DNBStimulus] = []
    var currentStimulusIndex: Int = 0
    var isGameActive: Bool = false
}