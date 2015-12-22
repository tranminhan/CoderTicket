FactoryGirl.define do
  factory :region do
    name "Ho Chi Minh"
  end

  factory :hcm, class: Region do
    name "Ho Chi Minh"
  end
end
