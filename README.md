# PopeFeed

A modern social media-style platform that aggregates and displays papal documents from the Vatican in an accessible feed format with full multilanguage support.

## Features

- 📱 **Social Media Feed**: Instagram/LinkedIn-style card layout for papal documents
- 🌍 **Multilingual**: Support for 6+ languages (EN, ES, PT, IT, FR, LA)
- 📄 **PDF Viewer**: Embedded PDF.js with side-by-side language comparison
- 🔍 **Search & Filter**: By pope, document type, language, and date
- 📱 **Mobile Optimized**: Responsive design for all devices
- 🔄 **Offline Support**: Service Worker for PDF caching
- 🖼️ **Vatican Images**: Official pope photographs from Vatican website

## Quick Start

### Prerequisites
- Hugo Extended (latest version)
- Python 3.8+
- Node.js (for build tools)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/popefeed.git
   cd popefeed
   ```

2. **Set up Python scraper**
   ```bash
   cd scrapper
   pip install -r requirements.txt
   cd ..
   ```

3. **Run the scraper to generate API data**
   ```bash
   cd scrapper
   python main.py
   cd ..
   ```

4. **Download pope images from Vatican**
   ```bash
   python scrapper/image_downloader.py
   ```

5. **Generate posts API with pope images**
   ```bash
   python generate_posts_api.py
   ```

6. **Start the API server**
   ```bash
   python -m http.server 8000 --directory api
   ```

7. **Start Hugo development server** (in another terminal)
   ```bash
   cd site
   hugo server -D
   ```

8. **Visit the site**
   - Site: http://localhost:1313
   - API: http://localhost:8000

## Project Structure

```
popefeed/
├── site/                   # Hugo static site generator
│   ├── config/            # Hugo configuration
│   ├── content/           # Content files
│   ├── layouts/           # HTML templates
│   ├── assets/            # CSS/JS assets
│   └── i18n/              # Translation files
├── scrapper/              # Python Vatican scraper
│   ├── scrapper/         # Core scraping modules
│   ├── models/           # Data models
│   └── api_generator/    # API generation
├── api/                   # Generated API files (created by scraper)
│   ├── popes/            # Pope data and Vatican images
│   ├── documents/        # Document metadata and PDFs
│   ├── posts/            # Paginated posts API
│   └── feed/             # Language-specific feeds
├── SETUP.md              # Detailed setup guide
├── CLAUDE.md             # Development guide
└── README.md             # This file
```

## Development

### Running the Scraper
```bash
# Basic scraping (English only)
python main.py

# Resume interrupted scrape
python main.py --resume

# Download pope images from Vatican
python scrapper/image_downloader.py

# Generate posts API with pope images
python generate_posts_api.py
```

### Running Hugo Site
```bash
# Development server with drafts
hugo server -D

# Build for production
hugo --minify

# Build specific language
hugo --config config.toml,config-production.toml
```

### Key Commands
- `hugo server -D`: Start development server
- `hugo --minify`: Build optimized site
- `python main.py`: Run Vatican scraper
- `python main.py --resume`: Resume interrupted scrape
- `python scrapper/image_downloader.py`: Download pope images
- `python generate_posts_api.py`: Generate posts API

## API Structure

The scraper generates a complete API in the `/api/` directory:

- **`/api/popes.json`** - List of all popes
- **`/api/popes/{pope}.json`** - Individual pope data
- **`/api/popes/{pope}.jpg`** - Pope images from Vatican
- **`/api/documents.json`** - List of all documents
- **`/api/documents/{doc-id}.json`** - Document metadata
- **`/api/documents/{doc-id}/{lang}.pdf`** - PDF files by language
- **`/api/posts/index.json`** - Posts API metadata
- **`/api/posts/page=1.json`** - Paginated posts with pope images
- **`/api/feed/{lang}.json`** - Language-specific feeds

## Data Sources

All content is scraped from the official Vatican website:
- **Pope Information**: https://vatican.va/content/{pope}/{lang}/
- **Pope Images**: https://vatican.va/content/{pope}/img/biografia/
- **Documents**: https://vatican.va/content/{pope}/{lang}/{doc-type}/
- **PDFs**: https://vatican.va/content/dam/{pope}/pdf/

## Supported Languages

- **EN** - English
- **ES** - Spanish (Español)
- **PT** - Portuguese (Português)
- **IT** - Italian (Italiano)
- **FR** - French (Français)
- **LA** - Latin (Latina)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Vatican.va for providing the official papal documents
- Hugo community for the excellent static site generator
- PDF.js team for the PDF rendering library