module BoardsHelper
  def enum_to_percentage(attribute)
    case attribute
    when 'very_low'
      1
    when 'low'
      2
    when 'medium'
      3
    when 'high'
      4
    when 'very_high'
      5
    else
      0 # デフォルト値またはエラー値
    end
  end

  def render_progress_bar(board, attribute)
    label = attribute.to_s.humanize
    percentage = enum_to_percentage(board.send(attribute))
    render partial: 'boards/progress_bar', locals: { label:, percentage: }
  end

  def display_rating(rating)
    ratings = {
      'good' => '⭐️',
      'very_good' => '⭐️⭐️',
      'excellent' => '⭐️⭐️⭐️',
      'outstanding' => '⭐️⭐️⭐️⭐️',
      'exceptional' => '⭐️⭐️⭐️⭐️⭐️'
    }
    ratings[rating]
  end
end
