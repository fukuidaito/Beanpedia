FactoryBot.define do
  factory :board do
    title { 'Test Board' }
    body { 'This is a test board.' }
    acidity { 1 }
    bitterness { 1 }
    richness { 1 }
    association :user
  end
end
