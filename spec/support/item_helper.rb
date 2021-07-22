require 'factory_bot_rails'

module UserHelpers
    # FactoryBot.create actually creates the item in the database
    def create_item
        FactoryBot.create(:item, 
            name: "Charizard", 
            price: "10.3",  
            user_id: 1
        )
    end

    # FactoryBot.build just gives us the attributes
    def build_item
        FactoryBot.build(:item, 
            name: "Charizard", 
            price: "10.3", 
            user_id: 1
        )
    end
end