FactoryGirl.define do
  factory :comment do
    document
    user
    content "MyText"
  end
end
