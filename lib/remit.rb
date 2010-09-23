$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'openssl'
require 'net/https'
require 'uri'
require 'date'
require 'base64'
require 'erb'

require 'rubygems'
require 'relax'

require 'remit/common'
require 'remit/data_types'

require 'remit/inbound_request'
require 'remit/ipn_request'
require 'remit/pipeline_response'

require 'remit/cancel'
require 'remit/cancel_token'
require 'remit/discard_results'
require 'remit/error_codes'
require 'remit/fund_prepaid'
require 'remit/get_account_activity'
require 'remit/get_account_balance'
require 'remit/get_all_credit_instruments'
require 'remit/get_all_prepaid_instruments'
require 'remit/get_debt_balance'
require 'remit/get_outstanding_debt_balance'
require 'remit/get_payment_instruction'
require 'remit/get_pipeline'
require 'remit/get_prepaid_balance'
require 'remit/get_recipient_verification_status'
require 'remit/get_results'
require 'remit/get_token_usage'
require 'remit/get_tokens'
require 'remit/get_token_by_caller'
require 'remit/get_total_prepaid_liability'
require 'remit/get_transaction'
require 'remit/install_payment_instruction'
require 'remit/pay'
require 'remit/refund'
require 'remit/reserve'
require 'remit/retry_transaction'
require 'remit/settle'
require 'remit/settle_debt'
require 'remit/subscribe_for_caller_notification'
require 'remit/verify_signature'
require 'remit/unsubscribe_for_caller_notification'
require 'remit/write_off_debt'

module Remit
  class API < Relax::Service
    include Cancel
    include CancelToken
    include DiscardResults
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
    include GetResults
    include GetTokenUsage
    include GetTokens
    include GetTokenByCaller
    include GetTotalPrepaidLiability
    include GetTransaction
    include InstallPaymentInstruction
    include Pay
    include Refund
    include Reserve
    include RetryTransaction
    include Settle
    include SettleDebt
    include SubscribeForCallerNotification
    include VerifySignature
    include UnsubscribeForCallerNotification
    include WriteOffDebt

    API_ENDPOINT = 'https://fps.amazonaws.com/'
    API_SANDBOX = 'https://fps.sandbox.amazonaws.com/'
    PIPELINE_ENDPOINT = 'https://authorize.payments.amazon.com/cobranded-ui/actions/start'
    PIPELINE_SANDBOX = 'https://authorize.payments-sandbox.amazon.com/cobranded-ui/actions/start'
    API_VERSION = Date.new(2008, 9, 17).to_s
    SIGNATURE_VERSION = 2

    attr_reader :pipeline
    attr_reader :access_key
    attr_reader :secret_key

    def initialize(access_key, secret_key, sandbox = false)
      super((not sandbox) ? API_ENDPOINT : API_SANDBOX)
      @pipeline = ((not sandbox) ? PIPELINE_ENDPOINT : PIPELINE_SANDBOX)
      @access_key = access_key
      @secret_key = secret_key
    end
    
    # generates v1 signatures, for historical purposes.
    def self.signature_v1(path, params, secret_key)
      params = params.except('awsSignature', 'action', 'controller', 'id').sort_by{ |k,v| k.to_s.downcase }.map{|k,v| "#{k}=#{CGI.escape v}"}.join('&')
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
