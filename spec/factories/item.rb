FactoryBot.define do
    factory :category do
        name {"Japanese comics"} 
        followed_by_item factory: :item
    end
    factory :item do
    end
end