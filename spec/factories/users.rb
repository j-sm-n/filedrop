FactoryGirl.define do
  factory :user do
    name "Users Name"
    email "example@example.com"
    role 1
    sms_number "555-867-5309"
    password "MyString"
    password_confirmation "MyString"
  end
end
