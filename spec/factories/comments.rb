FactoryGirl.define do
  factory :comment do
    document
    user
    content Faker::Lorem.paragraph
  end
end
