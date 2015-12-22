FactoryGirl.define do
  factory :user do
    name 'wombat'
    email 'user@example.com'
    password_digest 'password'
  end
end