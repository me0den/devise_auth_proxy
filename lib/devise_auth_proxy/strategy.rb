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

        session[:http_cookie] = env["HTTP_COOKIE"]
        # remember_me(resource)
        success!(resource)
      end

    end
  end
end

Warden::Strategies.add(:auth_proxy_authenticatable, Devise::Strategies::AuthProxyAuthenticatable)