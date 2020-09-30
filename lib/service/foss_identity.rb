require 'net/http'
require 'uri'

module Service
  module FossIdentity
    def logout(path, cookie)
      Net::HTTP.post(
          URI(path),
          "cookie" => cookie
      )
    end
  end
end