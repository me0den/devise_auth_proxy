require 'net/http'
require 'uri'

module Service
  module FossIdentity
    module_function

    def sign_out(path, cookie)
      resp = Net::HTTP.post(
          URI(path),
          nil,
          "Cookie" => cookie
      )
      resp
    end
  end
end