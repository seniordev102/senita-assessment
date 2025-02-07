require "test_helper"

class Api::PeopleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_people_index_url
    assert_response :success
  end

  test "should get import" do
    get api_people_import_url
    assert_response :success
  end
end
