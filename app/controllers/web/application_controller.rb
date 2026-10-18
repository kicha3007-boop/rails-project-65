module Web
  class ApplicationController < ::ApplicationController
    include Pundit::Authorization

    helper_method :current_user, :signed_in?

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def signed_in?
      current_user.present?
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      session.delete(:user_id)
      @current_user = nil
    end

    def authenticate_user!
      return if signed_in?

      redirect_to root_path, alert: t("web.flash.authentication_required")
    end

    def user_not_authorized
      redirect_to root_path, alert: t("web.flash.not_authorized")
    end
  end
end
