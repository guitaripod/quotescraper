import Foundation
import Vapor

struct Quote: Content {
    var id = UUID()
    let quote: String
    let author: String
}
