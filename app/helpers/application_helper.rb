module ApplicationHelper

  def format_time(time)
    Time.at(time).utc.strftime('%H:%M:%S')
  end
end
