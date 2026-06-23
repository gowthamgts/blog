# Append `?ref=rss` to post permalinks in the generated Atom feed(s) so visits
# originating from the RSS feed are distinguishable in analytics.
#
# Done as a post-render hook rather than by overriding jekyll-feed's template,
# so the feed stays minified and we don't have to maintain a copy of the
# plugin's template across upgrades.
Jekyll::Hooks.register :pages, :post_render do |page|
  next unless page.output_ext == ".xml"
  next unless page.output.include?("http://www.w3.org/2005/Atom")

  # Only an entry's permalink carries a `title=` attribute on its alternate
  # link; the feed's own self/alternate links do not, so they're left alone.
  page.output = page.output.gsub(
    %r{(<link href="[^"]+?)(" rel="alternate" type="text/html" title=)},
    '\1?ref=rss\2'
  )
end
