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

module Amazon
module FPS

#
# Copyright:: Copyright (c) 2009 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
#
# RFC 2104-compliant HMAC signature for request parameters
#  Implements AWS Signature, as per following spec:
#
# If Signature Version is 1, it performs the following:
#
# Sorts all  parameters (including SignatureVersion and excluding Signature,
# the value of which is being created), ignoring case.
#
# Iterate over the sorted list and append the parameter name (in original case)
# and then its value. It will not URL-encode the parameter values before
# constructing this string. There are no separators.
#
# If Signature Version is 2, string to sign is based on following:
#
#    1. The HTTP Request Method followed by an ASCII newline (%0A)
#    2. The HTTP Host header in the form of lowercase host, followed by an ASCII newline.
#    3. The URL encoded HTTP absolute path component of the URI
#       (up to but not including the query string parameters);
#       if this is empty use a forward '/'. This parameter is followed by an ASCII newline.
#    4. The concatenation of all query string components (names and values)
#       as UTF-8 characters which are URL encoded as per RFC 3986
#       (hex characters MUST be uppercase), sorted using lexicographic byte ordering.
#       Parameter names are separated from their values by the '=' character
#       (ASCII character 61), even if the value is empty.
#       Pairs of parameter and values are separated by the '&' character (ASCII code 38).
#
class SignatureUtils

  SIGNATURE_KEYNAME = "Signature"
  SIGNATURE_METHOD_KEYNAME = "SignatureMethod"
  SIGNATURE_VERSION_KEYNAME = "SignatureVersion"

  HMAC_SHA256_ALGORITHM = "HmacSHA256"
  HMAC_SHA1_ALGORITHM = "HmacSHA1"

  def self.sign_parameters(args)
    signature_version = args[:parameters][SIGNATURE_VERSION_KEYNAME]
    string_to_sign = "";
    algorithm = 'sha1';
    if (signature_version == '1') then
      string_to_sign = calculate_string_to_sign_v1(args)
    elsif (signature_version == '2') then
      algorithm = get_algorithm(args[:parameters][SIGNATURE_METHOD_KEYNAME])
      string_to_sign = calculate_string_to_sign_v2(args)
    else
      raise "Invalid Signature Version specified"
    end
    return compute_signature(string_to_sign, args[:aws_secret_key], algorithm)
  end

  # Convert a string into URL encoded form.
  def self.urlencode(plaintext)
    CGI.escape(plaintext.to_s).gsub("+", "%20").gsub("%7E", "~")
  end

  private # All the methods below are private

  def self.calculate_string_to_sign_v1(args)
    parameters = args[:parameters]

    # exclude any existing Signature parameter from the canonical string
    sorted = (parameters.reject { |k, v| k == SIGNATURE_KEYNAME }).sort { |a,b| a[0].downcase <=> b[0].downcase }

    canonical = ''
    sorted.each do |v|
      canonical << v[0]
      canonical << v[1] unless(v[1].nil?)
    end

    return canonical
  end

  def self.calculate_string_to_sign_v2(args)
    parameters = args[:parameters]

    uri = args[:uri]
    uri = "/" if uri.nil? or uri.empty?
    uri = urlencode(uri).gsub("%2F", "/")

    verb = args[:verb]
    host = args[:host].downcase

    # exclude any existing Signature parameter from the canonical string
    sorted = (parameters.reject { |k, v| k == SIGNATURE_KEYNAME })

    # sort the parameters
    sorted = sorted.sort{ |a, b| a.to_s <=> b.to_s }

    canonical = "#{verb}\n#{host}\n#{uri}\n"
    isFirst = true

    sorted.each { |v|
      if(isFirst) then
        isFirst = false
      else
        canonical << '&'
      end

      canonical << urlencode(v[0])
      unless(v[1].nil?) then
        canonical << '='
        canonical << urlencode(v[1])
      end
    }

    return canonical
  end

  def self.get_algorithm(signature_method)
    return 'sha256' if (signature_method == HMAC_SHA256_ALGORITHM);
    return 'sha1'
  end

  def self.compute_signature(canonical, aws_secret_key, algorithm = 'sha1')
    digest = OpenSSL::Digest::Digest.new(algorithm)
    return Base64.encode64(OpenSSL::HMAC.digest(digest, aws_secret_key, canonical)).chomp
  end

end

end
end

