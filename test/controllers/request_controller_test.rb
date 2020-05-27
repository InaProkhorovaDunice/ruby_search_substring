require 'test_helper'
require_relative '../helpers/authorization_helper'

class RequestControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper
  def setup
    test_user = { email: 'user@test.com', password: 'testuser' }

    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
    @user = User.first
  end

  test "should give the correct search result and list of requests" do
    search_string = "aaaaaaa"
    substring = "aaa"
    post '/request/new_request', params: { request: { search_string: search_string, substring: substring } },
         headers: @auth_tokens

    new_request = Request.last
    assert_response :success
    assert_equal search_string, new_request.search_string
    assert_equal true, new_request.result

    get '/request/', headers: @auth_tokens

    assert_equal 1, @user.requests.count
  end
end
