FactoryBot.define do
  factory :repository do
    sequence(:name) {|n| "Repository #{1}" }
  end
end
