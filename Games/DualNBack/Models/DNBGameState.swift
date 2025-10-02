import Foundation
import SwiftUI

enum MatchFeedback {
    case none
    case correct
    case incorrect

    var color: Color {
        switch self {
        case .none:
            return .clear
        case .correct:
            return .green
        case .incorrect:
            return .red
        }
    }
}

struct DNBGameState {
    var level: Int = 1
    var score: Int = 0
    var stimuli: [DNBStimulus] = []
    var currentStimulusIndex: Int = 0
    var isGameActive: Bool = false

    var stimulusHistory: [DNBStimulus] = []
    var feedback: MatchFeedback = .none
}