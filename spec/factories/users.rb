FactoryGirl.define do
  factory :user do
    name "Users Name"
    email "example@example.com"
    role 0
    sms_number ENV['TEST_PHONE_NUMBER']
    password "MyString"
    password_confirmation "MyString"
    authy_id nil
  end
end
