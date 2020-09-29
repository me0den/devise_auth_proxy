require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class AuthProxyAuthenticatable < Authenticatable

      def valid?
        DeviseAuthProxy.remote_user_id(env).present?
      end

      def authenticate!
        resource = mapping.to.find_for_auth_proxy_authentication(env)
        resource ? success!(resource) : fail
      end

    end
  end
end

Warden::Strategies.add(:auth_proxy_authenticatable, Devise::Strategies::AuthProxyAuthenticatable)