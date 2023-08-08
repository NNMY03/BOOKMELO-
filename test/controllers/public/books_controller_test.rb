require "test_helper"

class Public::BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_books_new_url
    assert_response :success
  end
end
