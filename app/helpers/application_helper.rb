module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.utc.in_time_zone(current_user.time_zone)
    end

    dt.strftime('%m/%d/%Y %l:%M%p %Z')
  end
end
