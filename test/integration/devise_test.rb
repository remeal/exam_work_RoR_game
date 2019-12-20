require 'test_helper'

class DeviseTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'don`t create session for nonexistent user' do
    get root_url, params: {email: 'qwerty@qwerty.com', password: '123'}
    assert session[:user_id].nil?
  end
  test 'add to database' do
    get '/users/sign_up', params: { email: 'test@sample.com',
                                      password: '123456', }
    assert User.find_by_email('test@sample.com')
  end
  test 'don`t get this page without authentication' do
    get root_url
    assert_redirected_to '/users/sign_in'

    get result_url
    assert_redirected_to '/users/sign_in'

    get game_url
    assert_redirected_to '/users/sign_in'

    get rank_url
    assert_redirected_to '/users/sign_in'
  end
end