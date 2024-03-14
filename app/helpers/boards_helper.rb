module BoardsHelper
  def enum_to_percentage(attribute)
    case attribute
    when 'very_low'
      20
    when 'low'
      40
    when 'medium'
      60
    when 'high'
      80
    when 'very_high'
      100
    else
      0 # デフォルト値またはエラー値
    end
  end

  def render_progress_bar(board, attribute)
    label = attribute.to_s.humanize
    percentage = enum_to_percentage(board.send(attribute))
    render partial: 'boards/progress_bar', locals: { label:, percentage: }
  end
end
