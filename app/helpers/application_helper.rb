module ApplicationHelper
  def format_comment_time(date)
    date.strftime("posted on %m/%d/%Y")
  end
end
