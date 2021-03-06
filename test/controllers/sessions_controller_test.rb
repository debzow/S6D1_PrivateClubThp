require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @michael = users(:michael)
  end

  test "login with valid information" do
    get login_path
    post login_path, params:{user:{ email:@michael.email}}
    assert_redirected_to @michael
    follow_redirect!
    assert_template 'users/show'
    assert flash.empty?
    assert is_logged_in?
  end

  test "no login with invalid information" do
    get login_path
    post login_path, params:{user:{ email:"faux@email.com"}}
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "access to users/index with a logged in user" do
    get login_path
    post login_path, params:{user:{ email:@michael.email}}
    assert is_logged_in?
    get users_path
    assert_template 'users/index'
  end

  test "no access to users/index without a logged in user" do
    get users_path
    assert_template 'users/new'
    assert_not flash.empty?
  end

end
