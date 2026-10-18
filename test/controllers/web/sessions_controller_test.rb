require "test_helper"

module Web
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    test "#destroy" do
      sign_in users(:regular)

      delete session_path

      assert_redirected_to root_path
      assert { session[:user_id].nil? }
    end
  end
end
