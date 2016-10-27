FactoryGirl.define do
  factory :folder do
    name Faker::File.file_name
    user
  end
end
