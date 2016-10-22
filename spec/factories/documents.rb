FactoryGirl.define do
  factory :document do
    filename "MyString"
    content_type "MyString"
    data ""
    user
  end
end
