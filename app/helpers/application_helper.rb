module ApplicationHelper

  def format_time(time)
    Time.at(time).utc.strftime('%H:%M:%S')
  end

  def format_date
    strftime('%b %Y')
  end
end
