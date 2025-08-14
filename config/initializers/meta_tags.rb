MetaTags.configure do |config|
  # How many characters should the title meta tag have at most. Default is 70.
  # Set to nil or 0 to remove limits.
  config.title_limit = 70

  # When true, site title will be truncated instead of title. Default is false.
  config.truncate_site_title_first = false

  # Maximum length of the page description. Default is 300.
  config.description_limit = 300

  # Maximum length of the keywords meta tag. Default is 255.
  config.keywords_limit = 255

  # Default separator for keywords meta tag (used when an Array passed with
  # the :keywords key). Default is ", ".
  config.keywords_separator = ', '

  # When true, keywords will be converted to lowercase, otherwise they will
  # appear on the page as is. Default is true.
  config.keywords_lowercase = true

  # List of additional meta tags that should use "property" attribute instead
  # of "name" attribute.
  config.property_tags.push(
    'og:title',
    'og:description',
    'og:image',
    'og:url',
    'og:type',
    'og:site_name',
    'twitter:card',
    'twitter:site',
    'twitter:creator',
    'twitter:title',
    'twitter:description',
    'twitter:image'
  )
end