module Web
  module Admin
    class BulletinsController < ApplicationController
      before_action :set_bulletin, only: %i[publish reject archive]

      def index
        @q = Bulletin.ransack(params[:q])
        @bulletins = @q.result.includes(:category, :user).order(created_at: :desc).page(params[:page])
        @categories = Category.order(:name)
      end

      def publish
        change_state(:publish)
      end

      def reject
        change_state(:reject)
      end

      def archive
        change_state(:archive)
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end

      def change_state(event)
        if @bulletin.aasm.may_fire_event?(event)
          @bulletin.aasm.fire!(event)
          redirect_back_or_to admin_root_path, notice: t(".success")
        else
          redirect_back_or_to admin_root_path, alert: t("web.flash.invalid_transition")
        end
      end
    end
  end
end
