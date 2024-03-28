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
    case rating
    when 'good'
      '⭐️'
    when 'very_good'
      '⭐️⭐️'
    when 'excellent'
      '⭐️⭐️⭐️'
    when 'outstanding'
      '⭐️⭐️⭐️⭐️'
    when 'exceptional'
      '⭐️⭐️⭐️⭐️⭐️'
    end
  end
end
