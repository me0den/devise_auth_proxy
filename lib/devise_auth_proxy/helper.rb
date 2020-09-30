module DeviseAuthProxy
  module Helper

    # Modify session controller after user log out.
    # To redirect user to a custom url.
    def after_sign_out_path_for(resource_or_scope)
      DeviseAuthProxy.logout_url if proxy_user_authenticated? and DeviseAuthProxy.logout_url
      super
    end

    private

    def proxy_user_authenticated?
      DeviseAuthProxy.proxy_user_id(request.env).present?
    end
  end
end