module Web
  class AuthController < ApplicationController
    def callback
      auth = request.env["omniauth.auth"]
      user = User.find_or_initialize_by(email: auth.info.email.to_s.downcase)
      user.name = auth.info.name.presence || auth.info.nickname
      # Права администратора только выдаются (тестовый вход), но не отзываются при обычном входе
      user.admin = true if auth.extra&.admin
      user.save!

      sign_in(user)
      redirect_to root_path, notice: t(".success")
    end
  end
end
