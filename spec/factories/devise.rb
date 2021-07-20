FactoryBot.define do
    factory :user do
        id {1}
        email {"test@admin.com"}
        password {"qwerty"}
        password_confirmation {"qwerty"}
        role { "Admin"}
    end

end