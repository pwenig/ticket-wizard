# This will guess the User class
FactoryBot.define do
  factory :user do
    name { "Test User" }
    email  { "test@test.com" }
    password { "password"}
    password_confirmation {"password"}
  end
end
