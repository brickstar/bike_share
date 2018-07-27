module ApplicationHelper

  def format_time(time)
    Time.at(time).utc.strftime('%H:%M:%S')
  end

  def login_path?
    controller_name == 'sessions' && action_name == 'new'
  end
end
