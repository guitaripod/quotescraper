@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    
    func testQuotes() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)
        
        try app.test(.GET, "quotes") { res in
            XCTAssertEqual(res.status, .ok)
            
            let quotes = try res.content.decode([Quote].self)
            XCTAssertFalse(quotes.isEmpty)
        }
    }
}
