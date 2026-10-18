require "test_helper"

module Web
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    test "#show" do
      sign_in users(:regular)
      get profile_path

      assert_response :success
      assert { response.body.include?(bulletins(:draft).title) }
      assert { !response.body.include?(bulletins(:published).title) }
    end
  end
end
