module ApplicationHelper
  include Pagy::Frontend

  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def assign_meta_tags(options = {})
    defaults = t('meta_tags.defaults', default: {}).with_indifferent_access
    options.reverse_merge!(defaults)

    configs = build_meta_tags_config(options)
    set_meta_tags(configs)
  end

  private

  def build_meta_tags_config(options)
    site = options[:site]
    title = options[:title]
    description = options[:description]
    keywords = options[:keywords]
    image = options[:image].presence || image_url('coffetop.png')

    {
      separator: '|',
      reverse: true,
      site:,
      title:,
      description:,
      keywords:,
      canonical: request.original_url,
      icon: {
        href: image_url('coffetop.png')
      },
      og: build_og_tags(site, title, description, image),
      twitter: build_twitter_tags(site, image)
    }
  end

  def build_og_tags(site, title, description, image)
    {
      type: 'website',
      title: title.presence || site,
      description:,
      url: request.original_url,
      image:,
      site_name: site
    }
  end

  def build_twitter_tags(site, image)
    {
      site:,
      card: 'summary_large_image',
      image:
    }
  end
end
