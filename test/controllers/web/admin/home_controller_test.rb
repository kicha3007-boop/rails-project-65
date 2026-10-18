require "test_helper"

module Web
  module Admin
    class HomeControllerTest < ActionDispatch::IntegrationTest
      test "#index" do
        sign_in users(:admin)
        get admin_root_path

        assert_response :success
        assert { response.body.include?(bulletins(:under_moderation).title) }
      end

      test "#index is forbidden for regular user" do
        sign_in users(:regular)
        get admin_root_path

        assert_redirected_to root_path
      end
    end
  end
end
