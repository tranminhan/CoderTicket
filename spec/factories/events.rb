FactoryGirl.define do
  factory :event do
    starts_at 1.day.from_now
    extended_html_description "desc"
    status 'Published'
  end
end
