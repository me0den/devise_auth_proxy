require 'service/foss_identity'

module DeviseAuthProxy
  module Helper

    # Modify session controller after user log out.
    # To redirect user to a custom url.
    def after_sign_out_path_for(resource_or_scope)
      unless DeviseAuthProxy.logout_service.nil?
        case DeviseAuthProxy.logout_service
        when 'foss_identity'
          Service::FossIdentity.sign_out(DeviseAuthProxy.logout_url, DeviseAuthProxy.http_cookie)
        else
          # do nothing
        end
      end

      return DeviseAuthProxy.logout_url if DeviseAuthProxy.logout_url
      super
    end
  end
end