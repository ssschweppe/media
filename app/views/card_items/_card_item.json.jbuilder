json.extract! card_item, :id, :kind, :text, :position, :breakdown_id, :source_id, :created_at, :updated_at
json.url card_item_url(card_item, format: :json)
