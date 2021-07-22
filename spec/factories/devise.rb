FactoryBot.define do
    factory :user do
        # id {1}
        email {"test@test.com"}
        password {"qwerty"}
        password_confirmation {"qwerty"}
        role { "Admin"}
    end

    
    factory :category do
        name {"Pokemon"}
    end

    factory :item do
    end
end