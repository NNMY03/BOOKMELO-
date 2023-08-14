require "test_helper"

class Public::AttentionsControllerTest < ActionDispatch::IntegrationTest
  test "should get attention" do
    get public_attentions_attention_url
    assert_response :success
  end
end
