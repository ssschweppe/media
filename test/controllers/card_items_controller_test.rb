require "test_helper"

class CardItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card_item = card_items(:one)
  end

  test "should get index" do
    get card_items_url
    assert_response :success
  end

  test "should get new" do
    get new_card_item_url
    assert_response :success
  end

  test "should create card_item" do
    assert_difference("CardItem.count") do
      post card_items_url, params: { card_item: { breakdown_id: @card_item.breakdown_id, kind: @card_item.kind, position: @card_item.position, source_id: @card_item.source_id, text: @card_item.text } }
    end

    assert_redirected_to card_item_url(CardItem.last)
  end

  test "should show card_item" do
    get card_item_url(@card_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_item_url(@card_item)
    assert_response :success
  end

  test "should update card_item" do
    patch card_item_url(@card_item), params: { card_item: { breakdown_id: @card_item.breakdown_id, kind: @card_item.kind, position: @card_item.position, source_id: @card_item.source_id, text: @card_item.text } }
    assert_redirected_to card_item_url(@card_item)
  end

  test "should destroy card_item" do
    assert_difference("CardItem.count", -1) do
      delete card_item_url(@card_item)
    end

    assert_redirected_to card_items_url
  end
end
