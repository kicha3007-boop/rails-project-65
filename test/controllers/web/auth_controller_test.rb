require "test_helper"

module Web
  class AuthControllerTest < ActionDispatch::IntegrationTest
    test "#callback signs in existing user" do
      user = users(:regular)

      sign_in user

      assert_redirected_to root_path
      assert { signed_in? }
      assert { current_user == user }
    end

    test "#callback creates new user" do
      email = Faker::Internet.email

      post auth_request_path("github", email: email)
      follow_redirect!

      assert { User.exists?(email: email.downcase) }
      assert { signed_in? }
    end
  end
end
