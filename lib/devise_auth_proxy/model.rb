require 'devise_auth_proxy/strategy'
require 'devise_auth_proxy/manager'

module Devise
  module Models
    module AuthProxyAuthenticatable
      extend ActiveSupport::Concern

      included do
        attr_reader :current_password, :password
      end

      module ClassMethod
        def self.find_for_auth_proxy_authentication(env)
          manager = DeviseAuthProxy::Manager.new(self, env)
          manager.find_or_create_user
        end
      end
    end
  end
end