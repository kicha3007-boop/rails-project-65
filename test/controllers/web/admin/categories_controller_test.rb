require "test_helper"

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        sign_in users(:admin)
        @attrs = { name: Faker::Lorem.unique.word }
      end

      test "#index" do
        get admin_categories_path

        assert_response :success
      end

      test "#new" do
        get new_admin_category_path

        assert_response :success
      end

      test "#create" do
        post admin_categories_path, params: { category: @attrs }

        assert_redirected_to admin_categories_path
        assert { Category.exists?(name: @attrs[:name]) }
      end

      test "#edit" do
        get edit_admin_category_path(categories(:transport))

        assert_response :success
      end

      test "#update" do
        category = categories(:transport)
        patch admin_category_path(category), params: { category: @attrs }

        assert_redirected_to admin_categories_path
        assert { category.reload.name == @attrs[:name] }
      end

      test "#destroy" do
        category = categories(:empty)
        delete admin_category_path(category)

        assert_redirected_to admin_categories_path
        assert { !Category.exists?(category.id) }
      end
    end
  end
end
