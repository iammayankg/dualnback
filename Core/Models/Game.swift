import Foundation

protocol Game: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var description: String { get }
}