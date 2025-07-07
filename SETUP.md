# PopeFeed Project Setup Prompt - Enhanced

## Project Overview
Create PopeFeed, a modern social media-style platform that aggregates and displays papal documents from the Vatican in an accessible feed format with full multilanguage support. The project consists of two main components: a Hugo static site generator for the frontend and a Python scraper/API generator for data collection.

## Component 1: Hugo Static Site Generator

### Project Structure
```
popefeed/
├── site/
│   ├── archetypes/
│   ├── assets/
│   │   ├── css/
│   │   └── js/
│   │       └── pdf-viewer.js
│   ├── content/
│   │   ├── popes/
│   │   │   ├── francis/
│   │   │   ├── benedict-xvi/
│   │   │   └── john-paul-ii/
│   │   └── documents/
│   │       ├── encyclicals/
│   │       ├── motu-proprio/
│   │       ├── homilies/
│   │       ├── apostolic-letters/
│   │       └── audiences/
│   ├── data/
│   │   └── api/ (symlink to ../api/)
│   ├── i18n/
│   │   ├── en.toml
│   │   ├── es.toml
│   │   ├── pt.toml
│   │   ├── it.toml
│   │   └── fr.toml
│   ├── layouts/
│   │   ├── _default/
│   │   ├── partials/
│   │   │   ├── feed-card.html
│   │   │   ├── pope-card.html
│   │   │   ├── filters.html
│   │   │   ├── language-switcher.html
│   │   │   └── pdf-viewer.html
│   │   ├── popes/
│   │   └── documents/
│   ├── static/
│   │   ├── js/
│   │   │   └── pdfjs/ (PDF.js library files)
│   │   └── api/ (symlink to ../api/)
│   └── config/
│       ├── _default/
│       │   └── config.toml
│       └── production/
│           └── config.toml
```

### Key Features to Implement

1. **Multilanguage Support**
   - Language switcher in header (EN, ES, PT, IT, FR, LA)
   - Automatic language detection based on browser
   - Each document available in multiple languages
   - Pope biographies translated
   - URL structure: `/en/popes/francis/` or `/es/papas/francisco/`
   - Fallback to English if translation unavailable

2. **Homepage Feed Layout**
   - Instagram/LinkedIn-style card layout
   - Language-aware content display
   - Each card shows:
     - Pope's official photo (circular avatar)
     - Pope's name (localized)
     - Document type badge (color-coded, translated)
     - Document title (in selected language)
     - Publication date (localized format)
     - Excerpt (first 150 characters)
     - Available languages indicator (flags or codes)
     - "Read More" link

3. **PDF Viewer Integration**
   - Embedded PDF viewer using PDF.js
   - Side-by-side language comparison mode
   - Download original PDF button
   - Full-screen reading mode
   - Search within PDF
   - Mobile-optimized PDF viewing
   - Offline PDF caching

4. **Filter System with Language Support**
   - Filter by Pope (localized names)
   - Filter by Document Type (translated)
   - Filter by Available Languages
   - Date range picker
   - Search in current language or all languages
   - Save filter preferences

### Hugo Configuration Requirements
```toml
# config/_default/config.toml
baseURL = "https://popefeed.com/"
title = "PopeFeed"
defaultContentLanguage = "en"
defaultContentLanguageInSubdir = true

[languages]
  [languages.en]
    title = "PopeFeed - Papal Documents in Your Feed"
    languageName = "English"
    weight = 1
  [languages.es]
    title = "PopeFeed - Documentos Papales en tu Feed"
    languageName = "Español"
    weight = 2
  [languages.pt]
    title = "PopeFeed - Documentos Papais no seu Feed"
    languageName = "Português"
    weight = 3
  [languages.it]
    title = "PopeFeed - Documenti Papali nel tuo Feed"
    languageName = "Italiano"
    weight = 4
  [languages.fr]
    title = "PopeFeed - Documents Papaux dans votre Flux"
    languageName = "Français"
    weight = 5
  [languages.la]
    title = "PopeFeed - Documenta Papalia"
    languageName = "Latina"
    weight = 6

[params]
  enablePDFViewer = true
  pdfWorkerSrc = "/js/pdfjs/pdf.worker.min.js"
  apiPath = "/api"
```

## Component 2: Python Vatican Data Scraper & API Generator

### Project Structure
```
popefeed/
├── scrapper/
│   ├── scrapper/
│   │   ├── __init__.py
│   │   ├── vatican_scraper.py
│   │   ├── document_parser.py
│   │   ├── pope_extractor.py
│   │   ├── image_downloader.py
│   │   ├── pdf_manager.py
│   │   ├── translation_detector.py
│   │   └── language_mapper.py
│   ├── models/
│   │   ├── __init__.py
│   │   ├── pope.py
│   │   └── document.py
│   ├── api_generator/
│   │   ├── __init__.py
│   │   ├── json_builder.py
│   │   ├── api_structure.py
│   │   └── data_validator.py
├── api/  # Output directory with API structure
│   ├── popes.json
│   ├── popes/
│   │   ├── francis.json
│   │   ├── francis.jpg
│   │   ├── francis-arms.png
│   │   ├── benedict-xvi.json
│   │   ├── benedict-xvi.jpg
│   │   └── ...
│   ├── documents.json
│   ├── documents/
│   │   ├── {document-id}.json
│   │   └── {document-id}/
│   │       ├── en.pdf
│   │       ├── es.pdf
│   │       ├── it.pdf
│   │       └── ...
│   ├── feed/
│   │   ├── en.json
│   │   ├── es.json
│   │   └── page-{n}.json
│   └── types/
│       ├── encyclicals.json
│       ├── motu-proprio.json
│       └── ...
├── requirements.txt
└── main.py
```

### Enhanced Data Models

```python
# Pope Model with Multilanguage Support
{
    "id": "francis",
    "names": {
        "en": "Pope Francis",
        "es": "Papa Francisco",
        "pt": "Papa Francisco",
        "it": "Papa Francesco",
        "fr": "Pape François",
        "la": "Franciscus"
    },
    "full_names": {
        "en": "Jorge Mario Bergoglio",
        "es": "Jorge Mario Bergoglio",
        "pt": "Jorge Mario Bergoglio",
        "it": "Jorge Mario Bergoglio",
        "fr": "Jorge Mario Bergoglio",
        "la": "Georgius Marius Bergoglio"
    },
    "image_url": "https://vatican.va/content/francesco/en/_jcr_content/image.img.jpeg",
    "local_image": "/api/popes/francis.jpg",
    "coat_of_arms": "/api/popes/francis-arms.png",
    "reign_start": "2013-03-13",
    "reign_end": null,
    "biographies": {
        "en": "Pope Francis is the 266th Pope...",
        "es": "El Papa Francisco es el 266º Papa...",
        "pt": "O Papa Francisco é o 266º Papa...",
        "it": "Papa Francesco è il 266º Papa...",
        "fr": "Le Pape François est le 266e Pape..."
    },
    "predecessor": "benedict-xvi",
    "birth_date": "1936-12-17",
    "birth_place": {
        "en": "Buenos Aires, Argentina",
        "es": "Buenos Aires, Argentina",
        "pt": "Buenos Aires, Argentina",
        "it": "Buenos Aires, Argentina",
        "fr": "Buenos Aires, Argentine"
    },
    "papal_motto": {
        "la": "Miserando atque eligendo",
        "en": "By having mercy and by choosing",
        "es": "Compadeciendo y eligiendo",
        "pt": "Tendo misericórdia e escolhendo",
        "it": "Avendo pietà e scegliendo",
        "fr": "En ayant pitié et en choisissant"
    }
}

# Document Model with Multilanguage Support
{
    "id": "laudato-si-2015",
    "pope_id": "francis",
    "type": "encyclical",
    "date": "2015-05-24",
    "titles": {
        "en": "Laudato Si'",
        "es": "Laudato Si'",
        "pt": "Laudato Si'",
        "it": "Laudato Si'",
        "fr": "Laudato Si'",
        "la": "Laudato Si'"
    },
    "subtitles": {
        "en": "On Care for Our Common Home",
        "es": "Sobre el cuidado de la casa común",
        "pt": "Sobre o cuidado da casa comum",
        "it": "Sulla cura della casa comune",
        "fr": "Sur la sauvegarde de la maison commune"
    },
    "available_languages": ["en", "es", "pt", "it", "fr", "la"],
    "excerpts": {
        "en": "\"Laudato si', mi' Signore\" – \"Praise be to you, my Lord\"...",
        "es": "\"Laudato si', mi' Signore\" – \"Alabado seas, mi Señor\"...",
        "pt": "\"Laudato si', mi' Signore\" – \"Louvado sejas, meu Senhor\"...",
        "it": "\"Laudato si', mi' Signore\", cantava san Francesco d'Assisi...",
        "fr": "\"Laudato si', mi' Signore\" – \"Loué sois-tu, mon Seigneur\"..."
    },
    "full_texts": {
        "en": "Complete English text...",
        "es": "Texto completo en español...",
        "pt": "Texto completo em português...",
        "it": "Testo completo in italiano...",
        "fr": "Texte complet en français..."
    },
    "vatican_urls": {
        "en": "https://vatican.va/content/francesco/en/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si.html",
        "es": "https://vatican.va/content/francesco/es/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si.html",
        "pt": "https://vatican.va/content/francesco/pt/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si.html",
        "it": "https://vatican.va/content/francesco/it/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si.html",
        "fr": "https://vatican.va/content/francesco/fr/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si.html"
    },
    "pdf_urls": {
        "en": "https://vatican.va/content/dam/francesco/pdf/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si_en.pdf",
        "es": "https://vatican.va/content/dam/francesco/pdf/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si_sp.pdf",
        "pt": "https://vatican.va/content/dam/francesco/pdf/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si_po.pdf",
        "it": "https://vatican.va/content/dam/francesco/pdf/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si_it.pdf",
        "fr": "https://vatican.va/content/dam/francesco/pdf/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si_fr.pdf"
    },
    "local_pdfs": {
        "en": "/api/documents/laudato-si-2015/en.pdf",
        "es": "/api/documents/laudato-si-2015/es.pdf",
        "pt": "/api/documents/laudato-si-2015/pt.pdf",
        "it": "/api/documents/laudato-si-2015/it.pdf",
        "fr": "/api/documents/laudato-si-2015/fr.pdf"
    },
    "word_counts": {
        "en": 37000,
        "es": 38500,
        "pt": 38000,
        "it": 37500,
        "fr": 39000
    },
    "reading_times": {
        "en": 148,
        "es": 154,
        "pt": 152,
        "it": 150,
        "fr": 156
    },
    "tags": {
        "en": ["environment", "creation", "ecology"],
        "es": ["medio ambiente", "creación", "ecología"],
        "pt": ["meio ambiente", "criação", "ecologia"],
        "it": ["ambiente", "creazione", "ecologia"],
        "fr": ["environnement", "création", "écologie"]
    },
    "metadata": {
        "promulgation_location": "Vatican City",
        "feast_day": "Pentecost",
        "original_language": "it"
    }
}
```

### API Output Structure

```
api/
├── popes.json                    # List of all popes with basic info
├── popes/
│   ├── francis.json             # Complete pope data
│   ├── francis.jpg              # Pope photo
│   ├── francis-arms.png         # Coat of arms
│   ├── benedict-xvi.json
│   ├── benedict-xvi.jpg
│   └── ...
├── documents.json               # List of all documents
├── documents/
│   ├── laudato-si-2015.json    # Document metadata
│   ├── laudato-si-2015/        # Document assets
│   │   ├── en.pdf
│   │   ├── es.pdf
│   │   ├── it.pdf
│   │   └── ...
│   └── ...
├── feed/
│   ├── en/
│   │   ├── latest.json         # Latest 20 items
│   │   ├── page-1.json
│   │   ├── page-2.json
│   │   └── ...
│   ├── es/
│   │   └── ...
│   └── all.json                # Language-agnostic feed
├── types/
│   ├── encyclicals.json
│   ├── encyclicals/
│   │   ├── en.json
│   │   ├── es.json
│   │   └── ...
│   └── ...
└── search/
    ├── index-en.json           # Search index by language
    ├── index-es.json
    └── ...
```

## PDF.js Integration in Hugo

### PDF Viewer Component
```javascript
// site/assets/js/pdf-viewer.js
class PopeFeedPDFViewer {
    constructor(container, options = {}) {
        this.container = container;
        this.options = {
            enableSideBySide: true,
            enableSearch: true,
            enableDownload: true,
            enableFullscreen: true,
            ...options
        };
    }
 
    async loadDocument(documentId, language = 'en') {
        const pdfUrl = `/api/documents/${documentId}/${language}.pdf`;
        // Initialize PDF.js viewer
    }
 
    async compareDocs(documentId, lang1, lang2) {
        // Load two PDFs side by side for comparison
    }
}
```

### PDF Viewer Layout
```html
<!-- site/layouts/partials/pdf-viewer.html -->
<div id="pdf-viewer" class="pdf-container">
    <div class="pdf-toolbar">
        <select id="language-selector" class="form-select">
            {{ range .available_languages }}
            <option value="{{ . }}">{{ i18n . }}</option>
            {{ end }}
        </select>
        <button id="compare-mode">{{ i18n "compare_languages" }}</button>
        <button id="download-pdf">{{ i18n "download_pdf" }}</button>
        <button id="fullscreen">{{ i18n "fullscreen" }}</button>
    </div>
 
    <div class="pdf-content">
        <div id="pdf-canvas"></div>
        <div id="pdf-compare-canvas" style="display:none;"></div>
    </div>
 
    <div class="pdf-navigation">
        <button id="prev-page">←</button>
        <span id="page-info">Page <span id="current-page">1</span> of <span id="total-pages">1</span></span>
        <button id="next-page">→</button>
    </div>
</div>
```

## Technical Requirements Updates

### Hugo Site:
- Hugo Extended version (for SCSS support)
- PDF.js v3.x for PDF rendering
- Language detection library
- LocalStorage for language preferences
- Service Worker for offline PDF caching

### Python Scraper:
- Language detection with `langdetect`
- PDF validation with `PyPDF2`
- Concurrent downloads with `aiohttp`
- Progress tracking for large scraping jobs
- Resume capability for interrupted scrapes

## Development Phases

### Phase 1: Foundation (High Priority)

#### 1. Basic scraper for English content
- [x] Create Python project structure with scrapper/ directory
- [x] Implement Vatican URL parsing for English documents
- [ ] Create Pope data model and extractor
- [ ] Create Document data model with English support
- [ ] Implement PDF download and validation
- [ ] Create basic JSON API output structure
- [ ] Test scraper with Pope Francis documents
- [ ] Test scraper with Pope Leon XIV documents

#### 2. Simple Hugo theme with PDF viewer
- [ ] Initialize Hugo site with basic config
- [ ] Create homepage feed layout template
- [ ] Design document card component
- [ ] Create pope profile page template
- [ ] Implement basic PDF viewer with PDF.js
- [ ] Add responsive CSS for mobile devices
- [ ] Create document detail page template

#### 3. API structure implementation
- [ ] Create api/ directory structure
- [ ] Implement JSON file generation for popes
- [ ] Implement JSON file generation for documents
- [ ] Create feed pagination system
- [ ] Implement document type categorization
- [ ] Create symlinks between Hugo and API data
- [ ] Validate API structure with Hugo consumption

### Phase 2: Core Features (Medium Priority)

#### 4. Scraper for all 6 languages
- [ ] Implement language detection and mapping
- [ ] Create multilingual Vatican URL builder
- [ ] Extend Pope model for all languages
- [ ] Extend Document model for all languages
- [ ] Implement concurrent scraping for multiple languages
- [ ] Add language-specific PDF downloads
- [ ] Test multilingual scraping with all popes

#### 5. Language switcher in UI
- [ ] Configure Hugo multilingual support
- [ ] Create language switcher component
- [ ] Implement language detection from browser
- [ ] Add language preference persistence
- [ ] Create language-specific URL routing
- [ ] Test language switching functionality

#### 6. Translated UI elements
- [ ] Create i18n translation files for all languages
- [ ] Translate all UI strings and labels
- [ ] Implement date formatting by language
- [ ] Add language-specific pope name display
- [ ] Translate document type badges
- [ ] Test all translations for accuracy

#### 7. PDF.js implementation
- [ ] Integrate PDF.js library into Hugo
- [ ] Create PDF viewer component class
- [ ] Implement PDF navigation controls
- [ ] Add PDF search functionality
- [ ] Create fullscreen PDF viewing mode
- [ ] Optimize PDF rendering for mobile
- [ ] Add PDF download button

#### 8. Side-by-side comparison
- [ ] Design dual-pane PDF viewer layout
- [ ] Implement language comparison selector
- [ ] Add synchronized scrolling between PDFs
- [ ] Create comparison mode toggle
- [ ] Test side-by-side on different screen sizes

### Phase 3: Optimization (Low Priority)

#### 9. Offline caching
- [ ] Implement Service Worker for caching
- [ ] Cache PDF files for offline access
- [ ] Cache API JSON files
- [ ] Add offline indicator to UI
- [ ] Test offline functionality

#### 10. Performance optimization
- [ ] Optimize image sizes and formats
- [ ] Implement lazy loading for PDFs
- [ ] Minify CSS and JavaScript
- [ ] Add compression for API files
- [ ] Run Lighthouse performance audit

#### 11. CDN setup for PDFs
- [ ] Research CDN providers for PDF hosting
- [ ] Configure CDN for PDF file delivery
- [ ] Update PDF URLs to use CDN
- [ ] Test CDN performance and reliability

#### 12. API caching strategy
- [ ] Implement Redis caching for API responses
- [ ] Add cache invalidation for updated content
- [ ] Configure cache headers for static files
- [ ] Monitor cache hit rates

#### 13. Complete documentation
- [ ] Update README with final installation guide
- [ ] Create API documentation
- [ ] Add deployment guide
- [ ] Create user guide for multilingual features
- [ ] Document troubleshooting common issues

## Success Metrics
- Support for 6+ languages
- 5000+ documents in multiple languages
- PDF rendering on all devices
- Language switch < 100ms
- Offline PDF access
- 95+ Lighthouse score

## Missing Data Requirements (TODO)

### High Priority Missing Data
1. **Pope Images and Assets**
   - [ ] Official pope photos for all popes (downloaded from Vatican.va)
   - [ ] Papal coat of arms images
   - [ ] Pope biography texts in all 6 languages
   - [ ] Pope birth dates and locations
   - [ ] Papal mottos in Latin and translations

2. **Document Full Text Content**
   - [ ] Complete document text extraction from Vatican website
   - [ ] Document excerpts (first 150 characters) in all languages
   - [ ] Document word counts and reading time estimation
   - [ ] Document tags and keywords in all languages

3. **Multilingual Content**
   - [ ] Pope names in all supported languages
   - [ ] Document titles and subtitles in all languages
   - [ ] Document type names translated
   - [ ] Location names translated (birth places, etc.)

4. **PDF Management**
   - [ ] PDF validation and download verification
   - [ ] PDF file size tracking
   - [ ] PDF availability status per language
   - [ ] PDF metadata extraction

### Medium Priority Missing Data
5. **Enhanced Metadata**
   - [ ] Document promulgation locations
   - [ ] Associated feast days or liturgical events
   - [ ] Document cross-references and citations
   - [ ] Historical context and significance notes

6. **User Experience Data**
   - [ ] Search index generation for all languages
   - [ ] Popular documents ranking
   - [ ] Document recommendation system data
   - [ ] User reading progress tracking

7. **Content Organization**
   - [ ] Document series and collections
   - [ ] Thematic categorization
   - [ ] Chronological ordering optimization
   - [ ] Related documents suggestions

### Low Priority Missing Data
8. **Advanced Features**
   - [ ] Audio versions of documents (if available)
   - [ ] Video content related to documents
   - [ ] Commentary and analysis texts
   - [ ] Historical photos and illustrations

9. **Social Features**
   - [ ] Document sharing statistics
   - [ ] User bookmarking system
   - [ ] Social media integration data
   - [ ] Community discussion features

10. **Analytics and Insights**
    - [ ] Document popularity metrics
    - [ ] Language preference statistics
    - [ ] User engagement tracking
    - [ ] Content performance analytics