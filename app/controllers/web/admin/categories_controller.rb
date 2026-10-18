module Web
  module Admin
    class CategoriesController < ApplicationController
      before_action :set_category, only: %i[edit update destroy]

      def index
        @categories = Category.order(:name).page(params[:page])
      end

      def new
        @category = Category.new
      end

      def create
        @category = Category.new(category_params)

        if @category.save
          redirect_to admin_categories_path, notice: t(".success")
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit; end

      def update
        if @category.update(category_params)
          redirect_to admin_categories_path, notice: t(".success")
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        if @category.destroy
          redirect_to admin_categories_path, notice: t(".success")
        else
          redirect_to admin_categories_path, alert: t(".failure")
        end
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
