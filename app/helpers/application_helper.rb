module ApplicationHelper
  def vnd(amount)
    number_to_currency(amount, :unit => " VND", :delimiter => ",", precision: 0, format: "%n %u")
  end 

  def bootstrap_class_for flash_type
    { success: 'alert-success', error: 'alert-danger', warning: 'alert-warning'}[flash_type.to_sym]
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "text-center alert #{bootstrap_class_for(msg_type)} fade in") do
        concat content_tag(:button, 'x'.html_safe, class: 'close', data: {dismiss: 'alert'})
        concat message
      end)
      flash.clear
    end
    nil
  end

  def pretty_time(time) 
    time.strftime "%a, %b %d %Y, %H:%M"
  end 


end
