import SwiftUI

protocol GameView: View {
    associatedtype ViewModel: GameViewModel

    var viewModel: ViewModel { get }
}