require 'test_helper'

class GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get genre" do
    get genres_genre_url
    assert_response :success
  end

end
