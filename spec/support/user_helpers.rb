require 'faker'
require 'factory_bot_rails'

module UserHelpers
    # FactoryBot.create actually creates the user in the database
    def create_user
        FactoryBot.create(:user, 
            email: "testuser@test.com", 
            password: "hahaha"
        )
    end

    # FactoryBot.build just gives us the attributes
    def build_user
        FactoryBot.build(:user, 
            email: "testuser@test.com", 
            password: Faker::Internet.password
        )
    end
end