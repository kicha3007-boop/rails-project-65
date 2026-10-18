module Web
  module Admin
    class ApplicationController < Web::ApplicationController
      before_action :authenticate_user!
      before_action :authorize_admin!

      private

      def authorize_admin!
        raise Pundit::NotAuthorizedError unless current_user.admin?
      end
    end
  end
end
