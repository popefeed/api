# PopeFeed - Git Subtree Management
# Manages subprojects using git subtree for better organization

# Repository URLs
API_REPO = git@github.com:popefeed/api.git
SCRAPPER_REPO = git@github.com:popefeed/scrapper.git
SITE_REPO = git@github.com:popefeed/site.git

# Subtree directories
API_DIR = api
SCRAPPER_DIR = scrapper
SITE_DIR = site

# Default branch
BRANCH = main

.PHONY: help setup-subtrees pull-all push-all
.PHONY: setup-api setup-scrapper setup-site
.PHONY: pull-api pull-scrapper pull-site
.PHONY: push-api push-scrapper push-site
.PHONY: status clean

# Default target
help:
	@echo "PopeFeed Subtree Management"
	@echo "=========================="
	@echo ""
	@echo "Setup Commands:"
	@echo "  setup-subtrees    Setup all subtrees (first time only)"
	@echo "  setup-api         Setup API subtree"
	@echo "  setup-scrapper    Setup scrapper subtree"
	@echo "  setup-site        Setup site subtree"
	@echo ""
	@echo "Update Commands:"
	@echo "  pull-all          Pull changes from all subtree remotes"
	@echo "  pull-api          Pull changes from API remote"
	@echo "  pull-scrapper     Pull changes from scrapper remote"
	@echo "  pull-site         Pull changes from site remote"
	@echo ""
	@echo "Push Commands:"
	@echo "  push-all          Push changes to all subtree remotes"
	@echo "  push-api          Push changes to API remote"
	@echo "  push-scrapper     Push changes to scrapper remote"
	@echo "  push-site         Push changes to site remote"
	@echo ""
	@echo "Utility Commands:"
	@echo "  status            Show git status for all subtrees"
	@echo "  clean             Remove subtree directories (careful!)"

# Setup all subtrees (first time only)
setup-subtrees: setup-api setup-scrapper setup-site
	@echo "✅ All subtrees setup complete"

# Setup individual subtrees
setup-api:
	@echo "🔧 Setting up API subtree..."
	@if [ -d "$(API_DIR)" ]; then \
		echo "⚠️  API directory already exists, skipping setup"; \
	else \
		git subtree add --prefix=$(API_DIR) $(API_REPO) $(BRANCH) --squash; \
		echo "✅ API subtree setup complete"; \
	fi

setup-scrapper:
	@echo "🔧 Setting up scrapper subtree..."
	@if [ -d "$(SCRAPPER_DIR)" ]; then \
		echo "⚠️  Scrapper directory already exists, skipping setup"; \
	else \
		git subtree add --prefix=$(SCRAPPER_DIR) $(SCRAPPER_REPO) $(BRANCH) --squash; \
		echo "✅ Scrapper subtree setup complete"; \
	fi

setup-site:
	@echo "🔧 Setting up site subtree..."
	@if [ -d "$(SITE_DIR)" ]; then \
		echo "⚠️  Site directory already exists, skipping setup"; \
	else \
		git subtree add --prefix=$(SITE_DIR) $(SITE_REPO) $(BRANCH) --squash; \
		echo "✅ Site subtree setup complete"; \
	fi

# Pull changes from all remotes
pull-all: pull-api pull-scrapper pull-site
	@echo "✅ All subtrees updated from remotes"

# Pull changes from individual remotes
pull-api:
	@echo "⬇️  Pulling API changes..."
	@if [ -d "$(API_DIR)" ]; then \
		git subtree pull --prefix=$(API_DIR) $(API_REPO) $(BRANCH) --squash; \
		echo "✅ API changes pulled"; \
	else \
		echo "❌ API directory not found. Run 'make setup-api' first"; \
	fi

pull-scrapper:
	@echo "⬇️  Pulling scrapper changes..."
	@if [ -d "$(SCRAPPER_DIR)" ]; then \
		git subtree pull --prefix=$(SCRAPPER_DIR) $(SCRAPPER_REPO) $(BRANCH) --squash; \
		echo "✅ Scrapper changes pulled"; \
	else \
		echo "❌ Scrapper directory not found. Run 'make setup-scrapper' first"; \
	fi

pull-site:
	@echo "⬇️  Pulling site changes..."
	@if [ -d "$(SITE_DIR)" ]; then \
		git subtree pull --prefix=$(SITE_DIR) $(SITE_REPO) $(BRANCH) --squash; \
		echo "✅ Site changes pulled"; \
	else \
		echo "❌ Site directory not found. Run 'make setup-site' first"; \
	fi

# Push changes to all remotes
push-all: push-api push-scrapper push-site
	@echo "✅ All subtrees pushed to remotes"

# Push changes to individual remotes
push-api:
	@echo "⬆️  Pushing API changes..."
	@if [ -d "$(API_DIR)" ]; then \
		git subtree push --prefix=$(API_DIR) $(API_REPO) $(BRANCH); \
		echo "✅ API changes pushed"; \
	else \
		echo "❌ API directory not found. Run 'make setup-api' first"; \
	fi

push-scrapper:
	@echo "⬆️  Pushing scrapper changes..."
	@if [ -d "$(SCRAPPER_DIR)" ]; then \
		git subtree push --prefix=$(SCRAPPER_DIR) $(SCRAPPER_REPO) $(BRANCH); \
		echo "✅ Scrapper changes pushed"; \
	else \
		echo "❌ Scrapper directory not found. Run 'make setup-scrapper' first"; \
	fi

push-site:
	@echo "⬆️  Pushing site changes..."
	@if [ -d "$(SITE_DIR)" ]; then \
		git subtree push --prefix=$(SITE_DIR) $(SITE_REPO) $(BRANCH); \
		echo "✅ Site changes pushed"; \
	else \
		echo "❌ Site directory not found. Run 'make setup-site' first"; \
	fi

# Show status of all subtrees
status:
	@echo "📊 Git Status for PopeFeed Subtrees"
	@echo "===================================="
	@echo ""
	@echo "Main Repository:"
	@git status --short
	@echo ""
	@if [ -d "$(API_DIR)" ]; then \
		echo "API Subtree ($(API_DIR)/):"; \
		cd $(API_DIR) && git log --oneline -5 || echo "No git history"; \
		echo ""; \
	fi
	@if [ -d "$(SCRAPPER_DIR)" ]; then \
		echo "Scrapper Subtree ($(SCRAPPER_DIR)/):"; \
		cd $(SCRAPPER_DIR) && git log --oneline -5 || echo "No git history"; \
		echo ""; \
	fi
	@if [ -d "$(SITE_DIR)" ]; then \
		echo "Site Subtree ($(SITE_DIR)/):"; \
		cd $(SITE_DIR) && git log --oneline -5 || echo "No git history"; \
		echo ""; \
	fi

# Clean subtree directories (use with caution)
clean:
	@echo "⚠️  This will remove all subtree directories!"
	@echo "Are you sure? This action cannot be undone."
	@read -p "Type 'yes' to continue: " confirm && [ "$$confirm" = "yes" ] || exit 1
	@if [ -d "$(API_DIR)" ]; then rm -rf $(API_DIR); echo "🗑️  Removed $(API_DIR)/"; fi
	@if [ -d "$(SCRAPPER_DIR)" ]; then rm -rf $(SCRAPPER_DIR); echo "🗑️  Removed $(SCRAPPER_DIR)/"; fi
	@if [ -d "$(SITE_DIR)" ]; then rm -rf $(SITE_DIR); echo "🗑️  Removed $(SITE_DIR)/"; fi
	@echo "✅ Cleanup complete"

# Development workflow shortcuts
dev-setup: setup-subtrees
	@echo "🚀 Development setup complete!"
	@echo ""
	@echo "Next steps:"
	@echo "1. cd scrapper && pip install -r requirements.txt"
	@echo "2. python scrapper/image_downloader.py"
	@echo "3. python generate_posts_api.py"
	@echo "4. python -m http.server 8000 --directory api"
	@echo "5. cd site && hugo server -D"

dev-update: pull-all
	@echo "🔄 Development update complete!"

dev-deploy: push-all
	@echo "🚀 Development deployment complete!"