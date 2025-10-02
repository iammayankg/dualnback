import Foundation
import AVFoundation

class AudioService {
    private let synthesizer = AVSpeechSynthesizer()

    func speak(letter: Character) {
        let utterance = AVSpeechUtterance(string: String(letter))
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = AVSpeechUtterance.defaultSpeechRate
        synthesizer.speak(utterance)
    }
}