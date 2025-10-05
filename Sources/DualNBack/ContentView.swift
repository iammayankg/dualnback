import SwiftUI

struct ContentView: View {
    var body: some View {
        // For now, we directly show the Dual-N-Back game.
        // In the future, this view can be expanded to a list of games.
        DNBStartView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}