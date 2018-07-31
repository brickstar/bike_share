module ApplicationHelper

  def format_time(time)
    Time.at(time).utc.strftime('%Hh %Mm %Ss')
  end

  def login_path?
    controller_name == 'sessions' && action_name == 'new'
  end
end
