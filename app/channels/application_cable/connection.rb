module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

      def find_verified_user
        cookie ||= cookies.encrypted[Rails.application.config.session_options[:key]]
        return if cookie['warden.user.user.key'].nil?
        if verified_user = User.find_by(id: cookie['warden.user.user.key'][0][0])
          verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
