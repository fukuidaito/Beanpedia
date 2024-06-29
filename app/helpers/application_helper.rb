module ApplicationHelper
  include Pagy::Frontend

  def default_meta_tags
    {
      site: 'beanpedia',
      title: 'コーヒーシェアリングサイト',
      reverse: true,
      charset: 'utf-8',
      description: 'お気に入りのコーヒーを投稿して広めよう！',
      keywords: 'コーヒー,coffee',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('sumaho.png'),
        local: 'ja-JP'
      },

      twitter: {
        card: 'summary_large_image',
        site: '@zutozako1',
        image: image_url('sumaho.png')
      }
    }
  end

  def assign_meta_tags(options = {})
  defaults = t('meta_tags.defaults', default: {}).with_indifferent_access
  options.reverse_merge!(defaults)

  if controller_name == 'boards' && action_name == 'show'
    options[:image] = @board.image_url if @board.present? && @board.image_url.present?
    options[:title] = @board.title if @board.present? && @board.title.present?
    options[:description] = @board.body if @board.present? && @board.body.present?
  end

  Rails.logger.debug "Meta tags options: #{options.inspect}"

  configs = build_meta_tags_config(options)
  set_meta_tags(configs)
end
end
