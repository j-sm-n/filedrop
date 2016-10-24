FactoryGirl.define do
  factory :document do
    filename "MyString"
    content_type "MyString"
    url "screenshot.png"
    user
  end
end
