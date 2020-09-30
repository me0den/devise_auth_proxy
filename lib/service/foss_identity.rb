require 'net/http'
require 'uri'

module Service
  module FossIdentity
    module_function

    def sign_out(path, cookie)
      Net::HTTP.post(
          URI(path),
          nil,
          "cookie" => cookie
      )
    end
  end
end