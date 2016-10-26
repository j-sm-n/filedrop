FactoryGirl.define do
  factory :document do
    filename "screenshot.png"
    content_type "MyString"
    url "https://filedrop-bucket.s3-us-west-1.amazonaws.com/screenshot.png"
    user
  end
end
