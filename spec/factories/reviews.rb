FactoryBot.define do
  factory :review do
    review { 'MyText' }
    stars { '' }
    board { nil }
    user { nil }
  end
end
