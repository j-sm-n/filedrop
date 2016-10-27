FactoryGirl.define do
  factory :document do
    filename Faker::File.file_name
    content_type Faker::Lorem.paragraph
    url Faker::File.file_name('path/to')
    user
  end
end
