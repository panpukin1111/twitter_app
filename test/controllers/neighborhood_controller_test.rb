require 'test_helper'

class NeighborhoodControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get neighborhood_new_url
    assert_response :success
  end

end
