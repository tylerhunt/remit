require 'base64'
require 'cgi'
#require 'openssl'
#require 'net/http'
#require 'net/https'

#Lifted From Amazon FPSRuby Code example and then refactored for remit
module Remit
  module SignatureUtilsForOutbound
    # Convert a string into URL encoded form.
    def urlencode(plaintext)
      CGI.escape(plaintext.to_s).gsub("+", "%20").gsub("%7E", "~")
    end

#    def get_http_data(url)
#      #2. fetch certificate if not found in cache
#      uri = URI.parse(url)
#      http_session = Net::HTTP.new(uri.host, uri.port)
#      http_session.use_ssl = true
#      http_session.ca_file = 'ca-bundle.crt'
#      http_session.verify_mode = OpenSSL::SSL::VERIFY_PEER
#      http_session.verify_depth = 5
#
#      res = http_session.start {|http_session|
#        req = Net::HTTP::Get.new(url, {"User-Agent" => USER_AGENT_STRING})
#        http_session.request(req)
#      }
#
#      return res.body
#    end
#
#    def starts_with(string, prefix)
#      prefix = prefix.to_s
#      string[0, prefix.length] == prefix
#    end

    def get_http_params(params)
       params.map do |(k, v)|
          urlencode(k) + "=" + urlencode(v)
       end.join("&")
    end

    SIGNATURE_KEYNAME = "signature"
    SIGNATURE_METHOD_KEYNAME = "signatureMethod"
    SIGNATURE_VERSION_KEYNAME = "signatureVersion"
    CERTIFICATE_URL_KEYNAME = "certificateUrl"
    SIGNATURE_VERSION_2 = "2"

    #Will raise an error if there are obvious problems with the request (indicating it was forged or corrupted)
    def check_parameters(params)
#      begin
        raise ":parameters must be enumerable" unless params.kind_of? Enumerable

        signature = params[SIGNATURE_KEYNAME];
        raise "'signature' is missing from the parameters." if (signature.nil?)

        signature_version = params[SIGNATURE_VERSION_KEYNAME];
        raise "'signatureVersion' is missing from the parameters." if (signature_version.nil?)
        raise "'signatureVersion' present in parameters is invalid. Valid values are: 2" if (signature_version != SIGNATURE_VERSION_2)

        signature_method = params[SIGNATURE_METHOD_KEYNAME]
        raise "'signatureMethod' is missing from the parameters." if (signature_method.nil?)

        certificate_url = params[CERTIFICATE_URL_KEYNAME]
        raise "'certificate_url' is missing from the parameters." if (certificate_url.nil?)
        return true
#      rescue
#        puts "There was a problem with parameters being invalid or missing."
#        return false
#      end
    end

  end
end
