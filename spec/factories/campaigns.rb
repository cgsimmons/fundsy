FactoryGirl.define do
  factory :campaign do

    association :user, factory: :user
    
    sequence(:title) { |n| "#{Faker::Company.bs} #{n}"}
    body {Faker::Hipster.paragraph}
    goal { 10 + rand(1000)}
    end_date {Time.now + 10.days }
  end
end
