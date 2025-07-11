# Pope Feed API

Pope Feed has **17,444 documents** and **12 popes** information in a structured way to help you easily create applications about papal documents and Vatican content.

## 📊 Overview

This repository contains the generated API files that serve as the backend data source for the Pope Feed platform. The API is generated by the [Pope Feed Scrapper](https://github.com/popefeed/scrapper) and consumed by the [Pope Feed Site](https://github.com/popefeed/site).

## 🗂️ API Structure

```
api/
├── popes.json              # List of all popes
├── popes/                  # Pope data and images
│   ├── francesco.jpg       # Official Vatican photos
│   ├── benedict-xvi.jpg
│   └── ...
├── documents/              # Document metadata and PDFs
│   ├── document-id.json    # Document metadata
│   └── document-id/
│       ├── en.pdf         # PDF files by language
│       ├── es.pdf
│       └── ...
├── posts/                  # Social media-style feed
│   ├── index.json         # Pagination metadata
│   ├── page=1.json        # First page (latest documents)
│   ├── page=2.json        # Second page
│   └── ...
└── feed/                   # Language-specific feeds
    ├── en.json            # English feed
    ├── es.json            # Spanish feed
    └── ...
```

## 🔗 API Endpoints

### Core Endpoints

- **`GET /popes.json`** - List of all popes with basic information
- **`GET /popes/{pope-id}.jpg`** - Official Vatican pope photographs
- **`GET /documents.json`** - Complete list of documents
- **`GET /documents/{doc-id}.json`** - Individual document metadata
- **`GET /documents/{doc-id}/{lang}.pdf`** - Document PDFs by language

### Posts API (Social Feed)

- **`GET /posts/index.json`** - Pagination metadata
- **`GET /posts/page=1.json`** - Latest 50 posts with pope avatars
- **`GET /posts/page={n}.json`** - Paginated posts (50 per page)

### Language Feeds

- **`GET /feed/en.json`** - English language feed
- **`GET /feed/es.json`** - Spanish language feed
- **`GET /feed/pt.json`** - Portuguese language feed
- **`GET /feed/it.json`** - Italian language feed
- **`GET /feed/fr.json`** - French language feed
- **`GET /feed/la.json`** - Latin language feed

## 📋 Data Models

### Pope Object
```json
{
  "id": "francesco",
  "names": {
    "en": "Pope Francis",
    "es": "Papa Francisco",
    "pt": "Papa Francisco",
    "it": "Papa Francesco",
    "fr": "Pape François",
    "la": "Franciscus Papa"
  },
  "image_url": "https://www.vatican.va/content/dam/francesco/img/biografia/img/foto_hi-res_13-03-2013-24-26-58.jpg",
  "local_image_path": "/api/popes/francesco.jpg",
  "reign": {
    "start": "2013-03-13",
    "end": null
  },
  "biographies": {
    "en": "Pope Francis is the 266th Pope of the Catholic Church..."
  }
}
```

### Document Object
```json
{
  "id": "papa-francesco_20150524_enciclica-laudato-si",
  "pope_id": "francesco",
  "type": "encyclical",
  "title": "Laudato si'",
  "date": "2015-05-24",
  "metadata": {
    "vatican_urls": {
      "en": "https://www.vatican.va/content/francesco/en/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si.html",
      "es": "https://www.vatican.va/content/francesco/es/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si.html"
    }
  }
}
```

### Post Object (Social Feed)
```json
{
  "id": "papa-francesco_20150524_enciclica-laudato-si",
  "pope": {
    "id": "francesco",
    "name": "Francis",
    "handle": "pontifex",
    "avatar": "http://localhost:8000/popes/francesco.jpg"
  },
  "document": {
    "title": "Laudato si'",
    "type": "Encyclical",
    "date": "2015-05-24",
    "excerpt": "Read the full text of this encyclical and discover the teachings within...",
    "language_count": 17,
    "pdf_available": true
  },
  "metadata": {
    "document_id": "papa-francesco_20150524_enciclica-laudato-si",
    "original_type": "encyclicals"
  }
}
```

## 🚀 Quick Start

### Serving the API Locally

```bash
# Clone this repository
git clone https://github.com/popefeed/api.git
cd api

# Serve with Python (recommended)
python -m http.server 8000

# Or serve with Node.js
npx http-server -p 8000 --cors

# API will be available at http://localhost:8000
```

### CORS Configuration

The API supports CORS for cross-origin requests. When serving locally, use:

```bash
# Python with CORS support
python -m http.server 8000

# Node.js with CORS
npx http-server -p 8000 --cors
```

## 🔄 Integration with Other Components

### With PopeFeed Scrapper

The API is generated by the [PopeFeed Scrapper](https://github.com/popefeed/scrapper):

```bash
# Clone and setup scrapper
git clone https://github.com/popefeed/scrapper.git
cd scrapper
pip install -r requirements.txt

# Generate API data
python main.py                              # Scrape documents
python scrapper/image_downloader.py         # Download Vatican images
python generate_posts_api.py                # Generate posts feed

# API files will be created in ../api/ directory
```

### With PopeFeed Site

The API is consumed by the [PopeFeed Site](https://github.com/popefeed/site):

```bash
# Clone and setup site
git clone https://github.com/popefeed/site.git
cd site

# Configure API base URL in hugo.toml
[params]
  api_base_url = "http://localhost:8000"

# Start development server
hugo server -D

# Site will fetch data from the API at http://localhost:8000
```

## 📦 Deployment

### Static Hosting

The API can be deployed to any static hosting service:

- **GitHub Pages**: Enable in repository settings
- **Netlify**: Connect repository and deploy
- **Vercel**: Import repository and deploy
- **AWS S3**: Upload files and configure static website hosting

### CDN Integration

For production use, serve through a CDN:

```bash
# Example with AWS CloudFront
aws s3 sync . s3://your-bucket-name
aws cloudfront create-invalidation --distribution-id YOUR_DIST_ID --paths "/*"
```

## 🌍 Supported Languages

- **EN** - English
- **ES** - Spanish (Español)
- **PT** - Portuguese (Português)
- **IT** - Italian (Italiano)
- **FR** - French (Français)
- **LA** - Latin (Latina)

## 📊 API Statistics

- **17,444 Documents** across multiple popes
- **6 Languages** supported (EN, ES, PT, IT, FR, LA)
- **12 Popes** with official Vatican images
- **Paginated Posts** (50 per page)
- **PDF Files** in multiple languages
- **Structured JSON** format for easy integration

## 🔗 Related Projects

- **[Pope Feed Scrapper](https://github.com/popefeed/scrapper)** - Generates this API data
- **[Pope Feed Site](https://github.com/popefeed/site)** - Frontend that consumes this API
- **[Pope Feed Main](https://github.com/popefeed/popefeed)** - Main repository with subtrees

## 📄 Data Source

All content is sourced from the official Vatican website:
- **Documents**: https://vatican.va/content/{pope}/{lang}/{doc-type}/
- **Pope Images**: https://vatican.va/content/{pope}/img/biografia/
- **PDFs**: https://vatican.va/content/dam/{pope}/pdf/

## 📜 License

MIT License - see LICENSE file for details.

## 🤝 Contributing

1. API content is generated automatically by the scrapper
2. To add new documents or fix data, contribute to the [Pope Feed Scrapper](https://github.com/popefeed/scrapper)
3. For API structure improvements, open an issue or pull request

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/popefeed/api/issues)
- **Documentation**: [PopeFeed Main Repo](https://github.com/popefeed/popefeed)
- **Vatican Source**: [Vatican.va](https://vatican.va)