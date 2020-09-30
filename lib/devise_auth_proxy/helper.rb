module DeviseAuthProxy
  module Helper

    # Modify session controller after user log out.
    # To redirect user to a custom url.
    def after_sign_out_path_for(resource_or_scope)
      unless DeviseAuthProxy.logout_service.nil?
        case DeviseAuthProxy.logout_service
        when 'foss_identity'
          Service::FossIdentity.logout(DeviseAuthProxy.logout_url, session[:http_cookie])
        else
          # do nothing
        end
      end

      session.delete(:http_cookie)

      return DeviseAuthProxy.logout_url if DeviseAuthProxy.logout_url
      super
    end
  end
end