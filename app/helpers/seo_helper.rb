module SeoHelper
  def default_meta_tags
    og_image = begin
      # Try to use og-placeholder.svg if it exists, otherwise use icon.png
      if Rails.application.assets_manifest.find_sources('og-placeholder.svg').any?
        image_url('og-placeholder.svg')
      elsif File.exist?(Rails.root.join('public', 'icon.png'))
        '/icon.png'
      else
        nil
      end
    rescue => e
      Rails.logger.debug "SEO Helper: Could not find OG image: #{e.message}"
      nil
    end

    {
      site: 'SaaS Foundation',
      title: 'SaaS Foundation - Rails 8 Template for Building SaaS Applications',
      description: 'A complete Rails 8 template with authentication, billing, background jobs, and deployment configuration for building SaaS applications.',
      keywords: 'rails, saas, template, authentication, billing, stripe, devise, sidekiq',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: '/icon.svg', type: 'image/svg+xml' },
        { href: '/icon.png', type: 'image/png' }
      ],
      og: {
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: og_image,
        site_name: 'SaaS Foundation'
      },
      twitter: {
        card: og_image ? 'summary_large_image' : 'summary',
        site: '@saas_foundation',
        creator: '@saas_foundation',
        title: :title,
        description: :description,
        image: og_image
      }
    }.compact
  end

  def page_title(title = nil)
    if title.present?
      "#{title} | SaaS Foundation"
    else
      'SaaS Foundation - Rails 8 Template for Building SaaS Applications'
    end
  end

  def page_description(description = nil)
    description.presence || 'A complete Rails 8 template with authentication, billing, background jobs, and deployment configuration for building SaaS applications.'
  end

  def page_keywords(keywords = nil)
    base_keywords = ['rails', 'saas', 'template', 'authentication', 'billing', 'stripe', 'devise', 'sidekiq']
    if keywords.present?
      additional_keywords = keywords.is_a?(Array) ? keywords : keywords.split(',').map(&:strip)
      (base_keywords + additional_keywords).uniq
    else
      base_keywords
    end
  end
end