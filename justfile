# List available recipes (default when running `just` with no args).
default:
    @just --list

# Scaffold a new post interactively (prompts for frontmatter).
new:
    ./scripts/new_post.rb

# Serve the site locally with live reload and drafts shown.
serve:
    bundle exec jekyll serve --livereload --drafts

# Build the production site into _site/.
build:
    JEKYLL_ENV=production bundle exec jekyll build

# Install/refresh gem dependencies.
install:
    bundle install

# Update gems to the latest allowed versions.
update:
    bundle update

# Remove generated site output and caches.
clean:
    bundle exec jekyll clean

# Build, then check for broken links/HTML in _site (requires htmlproofer).
check: build
    bundle exec htmlproofer _site --disable-external --allow-hash-href

# Aliases
alias s := serve
alias b := build
alias n := new
alias c := clean
