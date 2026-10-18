module Web
  class BulletinsController < ApplicationController
    before_action :authenticate_user!, except: %i[index show]
    before_action :set_bulletin, only: %i[show edit update to_moderate archive]

    def index
      @q = Bulletin.published.ransack(params[:q])
      @bulletins = @q.result.includes(:category, image_attachment: :blob)
                     .order(created_at: :desc).page(params[:page])
      @categories = Category.order(:name)
    end

    def show
      authorize @bulletin
    end

    def new
      @bulletin = current_user.bulletins.build
      authorize @bulletin
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)
      authorize @bulletin

      if @bulletin.save
        redirect_to profile_path, notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize @bulletin
    end

    def update
      authorize @bulletin

      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def to_moderate
      authorize @bulletin
      change_state(:to_moderate)
    end

    def archive
      authorize @bulletin
      change_state(:archive)
    end

    private

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def change_state(event)
      if @bulletin.aasm.may_fire_event?(event)
        @bulletin.aasm.fire!(event)
        redirect_to profile_path, notice: t(".success")
      else
        redirect_to profile_path, alert: t("web.flash.invalid_transition")
      end
    end

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
  end
end
