module Web
  class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
      @q = current_user.bulletins.ransack(params[:q])
      @bulletins = @q.result.includes(:category).order(created_at: :desc).page(params[:page])
      @categories = Category.order(:name)
    end
  end
end
