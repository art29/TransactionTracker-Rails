require "test_helper"

class Api::V1::TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_transaction = api_v1_transactions(:one)
  end

  test "should get index" do
    get api_v1_transactions_url, as: :json
    assert_response :success
  end

  test "should create api_v1_transaction" do
    assert_difference("Api::V1::Transaction.count") do
      post api_v1_transactions_url, params: { api_v1_transaction: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_transaction" do
    get api_v1_transaction_url(@api_v1_transaction), as: :json
    assert_response :success
  end

  test "should update api_v1_transaction" do
    patch api_v1_transaction_url(@api_v1_transaction), params: { api_v1_transaction: {  } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_transaction" do
    assert_difference("Api::V1::Transaction.count", -1) do
      delete api_v1_transaction_url(@api_v1_transaction), as: :json
    end

    assert_response :no_content
  end
end
