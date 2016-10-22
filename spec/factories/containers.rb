FactoryGirl.define do
  factory :container do
    folder
    after_create do |container|
      Factory(:folder, :container => container)     
    end
  end
end
