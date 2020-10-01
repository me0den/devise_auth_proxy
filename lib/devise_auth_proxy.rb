require 'devise'
require 'devise_auth_proxy/version'

module DeviseAuthProxy
  class << self
    attr_accessor :env_key, :auto_create, :auto_update, :auth_key,
                  :attribute_map, :default_role, :logout_service, :logout_url
  end

  # request.env key for remote user name
  # Set to 'HTTP_AUTH_PROXY' in config/initializers/devise.rb if behind reverse proxy
  self.env_key = 'AUTH_PROXY'

  # Enable user auto-creation of user from proxy user attributes
  self.auto_create = false

  # Enable user auto-update of user attributes from proxy user attributes
  self.auto_update = false

  # User attribute used for lookup of proxy user
  # Defaults to Devise.authentication_keys.first
  self.auth_key = nil

  # Map of User model attributes to request.env keys for updating a local user when auto-creation is enabled.
  self.attribute_map = {}

  # Set default role for new user.
  self.default_role = []

  # Set the service using to logout.
  self.logout_service = nil

  # Settings for redirecting to the remote user logout URL
  # Enable by including DeviseAuthProxy::Controllers::Helpers in ApplicationController
  # (it overrides Devise's after_sign_out_path_for method).
  self.logout_url = '/'

  def self.configure
    yield self
  end

  def self.proxy_user_id(env)
    case env_key
    when Proc
      env_key.call(env)
    else
      env[env_key]
    end
  end

  class Error < StandardError; end
end

Devise.add_module(:auth_proxy_authenticatable,
                  :strategy => true,
                  :controller => :sessions,
                  :model => 'devise_auth_proxy/model')