#module Remit
#  module Signature
#    def sign(secret_key, endpoint, http_verb, params)
#      s = string_to_sign(endpoint, http_verb, params)
#      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, secret_key, s)).strip
#    end
#
#    def string_to_sign(endpoint, http_verb, values)
#      uri = URI::parse(endpoint.to_s)
#
#      path = uri.path
#      path = "/" if (path.nil? || path.empty?)
#      path = urlencode(path).gsub("%2F", "/")
#
#      host = uri.host.downcase
#
#      # Explicitly remove the Signature param if found
#      sorted_keys = values.keys.reject{ |k| k.to_s == "Signature" }.sort { |x,y| x.to_s <=> y.to_s }
#      converted = sorted_keys.collect do |k|
#        v = values[k]
#        s = urlencode(k)
#        s << "=#{urlencode(v)}" unless v.nil?
#        s
#      end
#      params = converted.join("&")
#
#      "#{http_verb}\n#{host}\n#{path}\n#{params}"
#    end
#
#    # Convert a string into URL encoded form that Amazon accepts
#    def urlencode(plaintext)
#      CGI.escape(plaintext.to_s).gsub("+", "%20").gsub("%7E", "~")
#    end
#  end
#end
