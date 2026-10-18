require "test_helper"

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        sign_in users(:admin)
        @bulletin = bulletins(:under_moderation)
      end

      test "#index" do
        get admin_bulletins_path

        assert_response :success
      end

      test "#publish" do
        patch publish_admin_bulletin_path(@bulletin)

        assert_redirected_to admin_root_path
        assert { @bulletin.reload.published? }
      end

      test "#reject" do
        patch reject_admin_bulletin_path(@bulletin)

        assert_redirected_to admin_root_path
        assert { @bulletin.reload.rejected? }
      end

      test "#archive" do
        patch archive_admin_bulletin_path(@bulletin)

        assert_redirected_to admin_root_path
        assert { @bulletin.reload.archived? }
      end
    end
  end
end
