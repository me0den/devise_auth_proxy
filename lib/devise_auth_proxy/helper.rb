module DeviseAuthProxy
  module Helper

    # Modify session controller after user log out.
    # To redirect user to a custom url.
    def after_sign_out_path_for(resource_or_scope)
      return DeviseAuthProxy.logout_url if DeviseAuthProxy.logout_url
      super
    end
  end
end