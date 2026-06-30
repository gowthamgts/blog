#!/usr/bin/env ruby
# frozen_string_literal: true

# Interactively prompt for post frontmatter and scaffold a new Jekyll post.
#
#   ./scripts/new_post.rb
#
# Creates _posts/<category>/<YYYY-MM-DD>-<slug>.md with the standard
# frontmatter used across this blog. No external gems required.

require "time"

ROOT = File.expand_path("..", __dir__)
CATEGORIES = %w[blog til].freeze
IST = "+05:30"

# Read a line from the user, showing an optional default. Returns the default
# (or "") when the input is blank. Exits cleanly on Ctrl-D / Ctrl-C.
def prompt(label, default: nil)
  suffix = default && !default.empty? ? " [#{default}]" : ""
  print "#{label}#{suffix}: "
  answer = $stdin.gets
  abort("\nAborted.") if answer.nil? # Ctrl-D
  answer = answer.strip
  answer.empty? ? (default || "") : answer
rescue Interrupt
  abort("\nAborted.")
end

# Turn a title into a URL-friendly slug.
def slugify(text)
  text.downcase
      .gsub(/[^a-z0-9]+/, "-")
      .gsub(/\A-+|-+\z/, "")
end

# --- gather details -------------------------------------------------------

category = prompt("Category (#{CATEGORIES.join('/')})", default: CATEGORIES.first)
unless CATEGORIES.include?(category)
  abort("Unknown category '#{category}'. Choose one of: #{CATEGORIES.join(', ')}")
end

title = prompt("Title")
abort("Title is required.") if title.empty?

default_slug = slugify(title)
slug = slugify(prompt("Slug", default: default_slug))
abort("Could not derive a slug from the title.") if slug.empty?

tags = prompt("Tags (space-separated)")
description = prompt("Description")

now = Time.now.getlocal(IST)
date_str = now.strftime("%Y-%m-%d %H:%M:%S %z")
filename = "#{now.strftime('%Y-%m-%d')}-#{slug}.md"
path = File.join(ROOT, "_posts", category, filename)

if File.exist?(path)
  abort("Refusing to overwrite existing file: #{path}")
end

# --- write file -----------------------------------------------------------

frontmatter = <<~FRONTMATTER
  ---
  layout: post
  title: "#{title.gsub('"', '\"')}"
  date: #{date_str}
  category: #{category}
  tags: #{tags}
  description: #{description}
  ---
FRONTMATTER

File.write(path, frontmatter)

puts "\nCreated #{path.sub("#{ROOT}/", '')}"
