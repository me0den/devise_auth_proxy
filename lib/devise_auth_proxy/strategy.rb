require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class AuthProxyAuthenticatable < Authenticatable

      def valid?
        DeviseAuthProxy.proxy_user_id(env).present?
      end

      def authenticate!
        resource = mapping.to.find_for_auth_proxy_authentication(env)

        return fail(:invalid) unless resource

        # remember_me(resource)
        success!(resource)
      end

      def store?
        !DeviseAuthProxy.skip_session
      end

    end
  end
end

Warden::Strategies.add(:auth_proxy_authenticatable, Devise::Strategies::AuthProxyAuthenticatable)