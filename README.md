# Quotes Scraper

A simple backend service developed with Swift and Vapor framework that scrapes quotes from http://quotes.toscrape.com and returns them in a pretty JSON format.

## Features

- Fetches all quotes spanning multiple pages.
- Uses SwiftSoup for HTML parsing.
- Returns quotes in a structured JSON format with pretty-printed styling.
- Developed using Vapor, a popular web framework for Swift.
- Dockerized for easy setup and deployment.

## Installation & Setup

### Prerequisites

- Swift 5.2 or newer (if not using Docker).
- Vapor 4 or newer (if not using Docker).
- Docker and Docker Compose.

### Clone the Repository

```bash
git clone https://github.com/marcusziade/quotescraper.git
cd quotescraper
```

### Build and Run with Docker

1. **Build the Docker image:**

```bash
docker build -t quotescraper .
```

2. **Run the container:**

```bash
docker run -p 8080:8080 quotescraper
```

This will start the server at `localhost:8080`. To fetch quotes, navigate to `http://localhost:8080/quotes` in your browser or use any API testing tool like Postman.

### Build and Run without Docker

First, make sure you have Vapor's toolbox installed:

```bash
brew install vapor/tap/vapor
```

Then build and run:

```bash
vapor build
vapor run
```

## Usage

Make a GET request to `/quotes` endpoint to fetch all quotes:

```
GET /quotes
```

## API Response Example

```json
[
  {
    "id": "random-generated-id",
    "quote": "“The world as we have created it is a process of our thinking. It cannot be changed without changing our thinking.”",
    "author": "Albert Einstein"
  },
  ...
]
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License. See `LICENSE` for details.

