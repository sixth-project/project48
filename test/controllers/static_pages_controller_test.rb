require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @title = "Project48"
  end
  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "About | #{@title}"
  end

  test "should get top" do
    get root_url
    assert_response :success
    assert_select "title", "Home | #{@title}"
  end

  test "should get terms" do
    get terms_url
    assert_response :success
    assert_select "title", "Terms | #{@title}"
  end

  test "should get privacy" do
    get privacy_url
    assert_response :success
    assert_select "title", "Privacy policy | #{@title}"
  end

end
