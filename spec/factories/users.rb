FactoryGirl.define do
  factory :user do
    name "Users Name"
    email "MyString"
    role 1
    sms_number "555-867-5309"
    password_digest "MyString"
  end
end
