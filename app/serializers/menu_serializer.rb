class MenuSerializer
    def initialize(items)
      @items = items
    end
    # Create an array of items information and convert to json to send to front-end
    def serialize_new_items()
        serialized_array = []
        @items.each do |item|
            serialized_new_item = serialize_item(item)
            puts serialized_new_item
            serialized_array << serialized_new_item
        end
        serialized_array.to_json()
    end
  
    private def serialize_item(item)
      {
        id: item.id,
        image_url: item.get_image_url(),
        name: item.name,
        price: item.price,
        description: item.description,
        category_id: item.category_id,
        user_id: item.user_id,
        created_at: item.created_at
      }
    end
  end
  