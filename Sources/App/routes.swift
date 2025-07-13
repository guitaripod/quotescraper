import Vapor
import SwiftSoup

func routes(_ app: Application) throws {
    app.get("quotes") { req -> EventLoopFuture<Response> in
        fetchAllQuotes(on: req.client).flatMapThrowing { quotes in
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(quotes)
            
            let headers = HTTPHeaders([
                ("Content-Type", "application/json; charset=utf-8")
            ])
            
            return Response(status: .ok, headers: headers, body: .init(data: jsonData))
        }
    }
}

private func fetchAllQuotes(on client: Client, page: Int = 1) -> EventLoopFuture<[Quote]> {
    return fetchQuotes(on: client, page: page).flatMap { quotes in
        if quotes.isEmpty {
            return client.eventLoop.future([])
        } else {
            return fetchAllQuotes(on: client, page: page + 1).map { quotes + $0 }
        }
    }
}

private func fetchQuotes(on client: Client, page: Int) -> EventLoopFuture<[Quote]> {
    let uri = URI(string: "http://quotes.toscrape.com/page/\(page)")
    return client.get(uri).flatMapThrowing { response in
        guard
            let body = response.body,
            let htmlString = body.getString(at: 0, length: body.readableBytes)
        else {
            throw Abort(.internalServerError, reason: "Unable to fetch or decode quotes page")
        }
        
        return scrapedQuotes(from: htmlString)
    }
}

private func scrapedQuotes(from html: String) -> [Quote] {
    var quotesList: [Quote] = []
    
    do {
        let document = try SwiftSoup.parse(html)
        let quotes = try document.select("div.quote")
        
        for quoteElement in quotes {
            let quoteText = try quoteElement.select("span.text").text()
            let author = try quoteElement.select("small.author").text()
            quotesList.append(Quote(quote: quoteText, author: author))
        }
    } catch {
        print("Error: \(error.localizedDescription)")
    }
    
    return quotesList
}
