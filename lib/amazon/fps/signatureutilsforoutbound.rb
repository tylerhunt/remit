###############################################################################
 #  Copyright 2008-2010 Amazon Technologies, Inc
 #  Licensed under the Apache License, Version 2.0 (the "License");
 #
 #  You may not use this file except in compliance with the License.
 #  You may obtain a copy of the License at: http://aws.amazon.com/apache2.0
 #  This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 #  CONDITIONS OF ANY KIND, either express or implied. See the License for the
 #  specific language governing permissions and limitations under the License.
 ##############################################################################

require 'base64'
require 'cgi'
require 'openssl'
require 'net/http'
require 'net/https'
require 'rexml/document'

module Amazon
module FPS


class SignatureUtilsForOutbound

  SIGNATURE_KEYNAME = "signature"
  SIGNATURE_METHOD_KEYNAME = "signatureMethod"
  SIGNATURE_VERSION_KEYNAME = "signatureVersion"
  CERTIFICATE_URL_KEYNAME = "certificateUrl"
  CERTIFICATE_URL_ROOT = "https://fps.amazonaws.com/"
  CERTIFICATE_URL_ROOT_SANDBOX = "https://fps.sandbox.amazonaws.com/"

  FPS_PROD_ENDPOINT = CERTIFICATE_URL_ROOT
  FPS_SANDBOX_ENDPOINT = CERTIFICATE_URL_ROOT_SANDBOX
  ACTION_PARAM = "?Action=VerifySignature"
  END_POINT_PARAM = "&UrlEndPoint="
  HTTP_PARAMS_PARAM = "&HttpParameters="
  VERSION_PARAM_VALUE = "&Version=2008-09-17"

  USER_AGENT_STRING = "SigV2_MigrationSampleCode_Ruby-2010-09-13"

  SIGNATURE_VERSION_1 = "1"
  SIGNATURE_VERSION_2 = "2"
  RSA_SHA1_ALGORITHM = "RSA-SHA1"

  def initialize(aws_access_key, aws_secret_key)
    @aws_secret_key = aws_secret_key
    @aws_access_key = aws_access_key
  end

  def validate_request(args)
    parameters = args[:parameters]
    return validate_signature_v2(args) if (parameters[SIGNATURE_VERSION_KEYNAME] == SIGNATURE_VERSION_2)
    return validate_signature_v1(args)
  end

  def validate_signature_v1(args)
    parameters = args[:parameters]
    signature = "";
    if(parameters[SIGNATURE_KEYNAME] != nil) then
      signature = parameters[SIGNATURE_KEYNAME];
    else
       raise "Signature is missing from parameters"
    end

    canonical = SignatureUtilsForOutbound::calculate_string_to_sign_v1(args)
    digest = OpenSSL::Digest::Digest.new('sha1')
    return signature == Base64.encode64(OpenSSL::HMAC.digest(digest, @aws_secret_key, canonical)).chomp
  end

  def validate_signature_v2(args)
      [:parameters,
     :http_method,
     :url_end_point].each do |arg|
      raise "#{arg.inspect} is missing from the arguments." unless args[arg]
    end

    url_end_point = args[:url_end_point]

    parameters = args[:parameters]
    raise ":parameters must be enumerable" unless args[:parameters].kind_of? Enumerable

    signature = parameters[SIGNATURE_KEYNAME];
    raise "'signature' is missing from the parameters." if (signature.nil? or signature.empty?)

    signature_version = parameters[SIGNATURE_VERSION_KEYNAME];
    raise "'signatureVersion' is missing from the parameters." if (signature_version.nil? or signature_version.empty?)
    raise "'signatureVersion' present in parameters is invalid. Valid values are: 2" if (signature_version != SIGNATURE_VERSION_2)

    signature_method = parameters[SIGNATURE_METHOD_KEYNAME]
    raise "'signatureMethod' is missing from the parameters." if (signature_method.nil? or signature_method.empty?)
    signature_algorithm = SignatureUtilsForOutbound::get_algorithm(signature_method)
    raise "'signatureMethod' present in parameters is invalid. Valid values are: RSA-SHA1" if (signature_algorithm.nil?)

    certificate_url = parameters[CERTIFICATE_URL_KEYNAME]
    raise "'certificate_url' is missing from the parameters." if (certificate_url.nil? or certificate_url.empty?)

    # Construct VerifySignatureAPI request
    if(SignatureUtilsForOutbound::starts_with(certificate_url, FPS_SANDBOX_ENDPOINT) == true) then
       verify_signature_request = FPS_SANDBOX_ENDPOINT
    elsif(SignatureUtilsForOutbound::starts_with(certificate_url, FPS_PROD_ENDPOINT) == true) then
       verify_signature_request = FPS_PROD_ENDPOINT
    else
       raise "'certificateUrl' received is not valid. Valid certificate urls start with " <<
        CERTIFICATE_URL_ROOT << " or " << CERTIFICATE_URL_ROOT_SANDBOX << "."
    end

    verify_signature_request = verify_signature_request + ACTION_PARAM +
    END_POINT_PARAM +
    SignatureUtilsForOutbound::urlencode(url_end_point) +
    VERSION_PARAM_VALUE +
    HTTP_PARAMS_PARAM +
    SignatureUtilsForOutbound::urlencode(SignatureUtilsForOutbound::get_http_params(parameters))

    verify_signature_response = SignatureUtilsForOutbound::get_http_data(verify_signature_request)

    # parse the response
    document = REXML::Document.new(verify_signature_response)

    status_el = document.elements['VerifySignatureResponse/VerifySignatureResult/VerificationStatus']
    return (!status_el.nil? && status_el.text == "Success")
  end

  def self.calculate_string_to_sign_v1(args)
    parameters = args[:parameters]

    # exclude any existing Signature parameter from the canonical string
    sorted = (parameters.reject { |k, v| ((k == SIGNATURE_KEYNAME)) }).sort { |a,b| a[0].downcase <=> b[0].downcase }

    canonical = ''
    sorted.each do |v|
      canonical << v[0]
      canonical << v[1] unless(v[1].nil?)
    end

    return canonical
  end

  def self.get_algorithm(signature_method)
    return OpenSSL::Digest::SHA1.new if (signature_method == RSA_SHA1_ALGORITHM)
    return nil
  end

  # Convert a string into URL encoded form.
  def self.urlencode(plaintext)
    CGI.escape(plaintext.to_s).gsub("+", "%20").gsub("%7E", "~")
  end

  def self.get_http_data(url)
    #2. fetch certificate if not found in cache
    uri = URI.parse(url)
    http_session = Net::HTTP.new(uri.host, uri.port)
    http_session.use_ssl = true
    http_session.ca_file = File.dirname(__FILE__) + '/ca-bundle.crt'
    http_session.verify_mode = OpenSSL::SSL::VERIFY_PEER
    http_session.verify_depth = 5

    res = http_session.start {|http_session|
      req = Net::HTTP::Get.new(url, {"User-Agent" => USER_AGENT_STRING})
      http_session.request(req)
    }

    return res.body
  end

  def self.starts_with(string, prefix)
    prefix = prefix.to_s
    string[0, prefix.length] == prefix
  end

  def self.get_http_params(params)
     params.map do |(k, v)|
        urlencode(k) + "=" + urlencode(v)
     end.join("&")
  end

end

end
end

