$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'openssl'
require 'net/https'
require 'uri'
require 'date'
require 'base64'
require 'erb'
require 'cgi'

require 'rubygems'

gem 'relax', '0.0.7'
require 'relax'


require 'remit/data_types'
require 'remit/common'
require 'remit/error_codes'
require 'remit/signature_utils_for_outbound'
require 'remit/verify_signature'
require 'remit/inbound_request'
require 'remit/ipn_request'
require 'remit/get_pipeline'
require 'remit/pipeline_response'

require 'remit/operations/cancel_subscription_and_refund'
require 'remit/operations/cancel_token'
require 'remit/operations/cancel'
require 'remit/operations/fund_prepaid'
require 'remit/operations/get_account_activity'
require 'remit/operations/get_account_balance'
require 'remit/operations/get_all_credit_instruments'
require 'remit/operations/get_all_prepaid_instruments'
require 'remit/operations/get_debt_balance'
require 'remit/operations/get_outstanding_debt_balance'
require 'remit/operations/get_payment_instruction'
require 'remit/operations/get_prepaid_balance'
require 'remit/operations/get_recipient_verification_status'
require 'remit/operations/get_token_by_caller'
require 'remit/operations/get_token_usage'
require 'remit/operations/get_tokens'
require 'remit/operations/get_total_prepaid_liability'
require 'remit/operations/get_transaction'
require 'remit/operations/get_transaction_status'
require 'remit/operations/install_payment_instruction'
require 'remit/operations/pay'
require 'remit/operations/refund'
require 'remit/operations/reserve'
require 'remit/operations/settle'
require 'remit/operations/settle_debt'
require 'remit/operations/subscribe_for_caller_notification'
require 'remit/operations/unsubscribe_for_caller_notification'
require 'remit/operations/write_off_debt'

module Remit
  class API < Relax::Service

    include VerifySignature
    include CancelSubscriptionAndRefund
    include CancelToken
    include Cancel
    include FundPrepaid
    include GetAccountActivity
    include GetAccountBalance
    include GetAllCreditInstruments
    include GetAllPrepaidInstruments
    include GetDebtBalance
    include GetOutstandingDebtBalance
    include GetPaymentInstruction
    include GetPipeline
    include GetPrepaidBalance
    include GetRecipientVerificationStatus
    include GetTokenUsage
    include GetTokens
    include GetTokenByCaller
    include GetTotalPrepaidLiability
    include GetTransaction
    include InstallPaymentInstruction
    include Pay
    include Refund
    include Reserve
    include Settle
    include SettleDebt
    include SubscribeForCallerNotification
    include UnsubscribeForCallerNotification
    include WriteOffDebt

    API_ENDPOINT = 'https://fps.amazonaws.com/'.freeze
    API_SANDBOX_ENDPOINT = 'https://fps.sandbox.amazonaws.com/'.freeze
    PIPELINE_URL = 'https://authorize.payments.amazon.com/cobranded-ui/actions/start'.freeze
    PIPELINE_SANDBOX_URL = 'https://authorize.payments-sandbox.amazon.com/cobranded-ui/actions/start'.freeze
    API_VERSION = Date.new(2008, 9, 17).to_s.freeze
    PIPELINE_VERSION = Date.new(2009, 1, 9).to_s.freeze
    SIGNATURE_VERSION = 2.freeze
    SIGNATURE_METHOD = "HmacSHA256".freeze

    #attr_reader :pipeline      # kickstarter
    attr_reader :pipeline_url   # nyc
    attr_reader :access_key
    attr_reader :secret_key
    attr_reader :api_endpoint

    def initialize(access_key, secret_key, sandbox=false)
      @access_key = access_key
      @secret_key = secret_key
      @pipeline_url = sandbox ? PIPELINE_SANDBOX_URL : PIPELINE_URL
      @api_endpoint = sandbox ? API_SANDBOX_ENDPOINT : API_ENDPOINT
      super(@api_endpoint)
    end
    
    # generates v1 signatures, for historical purposes.
    def self.signature_v1(path, params, secret_key)
      params = params.reject {|key, val| ['awsSignature', 'action', 'controller', 'id'].include?(key) }.sort_by{ |k,v| k.to_s.downcase }.map{|k,v| "#{CGI::escape(k)}=#{Remit::SignedQuery.escape_value(v)}"}.join('&')
      signable = path + '?' + params
      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, secret_key, signable)).strip
    end

    private

    # called from Relax::Service#call
    def query(request)
      params = request.to_query.merge(
        :AWSAccessKeyId => @access_key,
        :Version => API_VERSION,
        :Timestamp => Time.now.utc.strftime('%Y-%m-%dT%H:%M:%SZ')
      )
      ApiQuery.new(@endpoint, @secret_key, params)
    end
  end
end

