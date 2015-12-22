module ApplicationHelper
  def vnd(amount)
    number_to_currency(amount, :unit => " VND", :delimiter => ",", precision: 0, format: "%n %u")
  end 
end
