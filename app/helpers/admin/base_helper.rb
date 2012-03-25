module Admin::BaseHelper
  def format_date(date, include_time = false)
    time = include_time ? " at %I:%M %p" : ""
    date.strftime("%B #{date.day.ordinalize}, %Y#{time}")
  end
end
