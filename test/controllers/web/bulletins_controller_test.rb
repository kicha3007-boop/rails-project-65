require "test_helper"

module Web
  class BulletinsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:regular)
      @attrs = {
        title: Faker::Lorem.characters(number: 20),
        description: Faker::Lorem.paragraph,
        category_id: categories(:transport).id,
        image: fixture_file_upload("bulletin.png", "image/png")
      }
    end

    test "#index shows only published bulletins" do
      get root_path

      assert_response :success
      assert { response.body.include?(bulletins(:published).title) }
      assert { !response.body.include?(bulletins(:draft).title) }
    end

    test "#show" do
      get bulletin_path(bulletins(:published))

      assert_response :success
    end

    test "#new" do
      sign_in @user
      get new_bulletin_path

      assert_response :success
    end

    test "#create" do
      sign_in @user
      post bulletins_path, params: { bulletin: @attrs }

      bulletin = Bulletin.find_by(title: @attrs[:title])

      assert { bulletin }
      assert { bulletin.user == @user }
      assert { bulletin.draft? }
      assert { bulletin.image.attached? }
      assert_redirected_to profile_path
    end

    test "#edit" do
      sign_in @user
      get edit_bulletin_path(bulletins(:draft))

      assert_response :success
    end

    test "#update" do
      bulletin = bulletins(:draft)
      sign_in @user
      patch bulletin_path(bulletin), params: { bulletin: { title: "Новый заголовок" } }

      assert_redirected_to profile_path
      assert { bulletin.reload.title == "Новый заголовок" }
    end

    test "#to_moderate" do
      bulletin = bulletins(:draft)
      sign_in @user
      patch to_moderate_bulletin_path(bulletin)

      assert_redirected_to profile_path
      assert { bulletin.reload.under_moderation? }
    end

    test "#archive" do
      bulletin = bulletins(:draft)
      sign_in @user
      patch archive_bulletin_path(bulletin)

      assert_redirected_to profile_path
      assert { bulletin.reload.archived? }
    end

    test "#new redirects guest" do
      get new_bulletin_path

      assert_redirected_to root_path
    end

    test "#update by other user is forbidden" do
      bulletin = bulletins(:draft)
      sign_in users(:other)
      patch bulletin_path(bulletin), params: { bulletin: { title: "Чужой заголовок" } }

      assert_redirected_to root_path
      assert { bulletin.reload.title != "Чужой заголовок" }
    end
  end
end
