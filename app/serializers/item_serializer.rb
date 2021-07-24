class ItemSerializer
  def initialize(item: nil)
    @item = item
  end

  def serialize_new_item()
    serialized_new_item = serialize_item(@item)
    serialized_new_item.to_json()
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
