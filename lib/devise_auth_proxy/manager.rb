module DeviseAuthProxy

  #
  # The Manager class is responsible for connecting the appliation's User
  # class with proxy user information in the request environment.
  #
  class Manager

    attr_reader :klass, :env

    def initialize(klass, env)
      @klass = klass
      @env = env
    end

    def find_or_create_user
      user = find_user
      if !user && DeviseAuthProxy.auto_create
        user = create_user
      end
      update_user(user) if user && DeviseAuthProxy.auto_update
      user
    end

    def find_user
      klass.where(user_criterion).first
    end

    def create_user
      unless Devise.mappings[:admin_user].strategies.include?(:database_authenticatable)
        return klass.create(user_criterion)
      end

      random_password = SecureRandom.hex(16)
      attrs = user_criterion.merge({
                                       password: random_password,
                                       password_confirmation: random_password,
                                       roles: DeviseAuthProxy.default_role
                                   })
      klass.create(attrs)
    end

    def update_user(user)
      user.update_attributes(proxy_user_attributes)
    end

    protected

    def proxy_user_attributes
      DeviseAuthProxy.attribute_map.inject({}) { |h, (k, v)| h[k] = env[v] if env.has_key?(v); h }
    end

    def user_criterion
      {auth_key => proxy_user_id}
    end

    def proxy_user_id
      DeviseAuthProxy.proxy_user_id(env)
    end

    def auth_key
      DeviseAuthProxy.auth_key || Devise.authentication_keys.first
    end
  end
end