require 'rubygems'
require 'relax'

require 'remit/common'

module Remit
  class Amount < BaseResponse
    parameter :currency_code
    parameter :amount, :type => :float
  end

  class TemporaryDeclinePolicy < BaseResponse
    parameter :temporary_decline_policy_type
    parameter :implicit_retry_timeout_in_mins
  end

  class DescriptorPolicy < BaseResponse
    parameter :soft_descriptor_type
    parameter :CS_number_of
  end

  class ChargeFeeTo
    CALLER = 'Caller'
    RECIPIENT = 'Recipient'
  end

  class Error < BaseResponse
    parameter :code
    parameter :message
  end

  class InstrumentStatus
    ALL = 'ALL'
    ACTIVE = 'Active'
    INACTIVE = 'Inactive'
  end

  class PaymentMethods
    BALANCE_TRANSFER = 'abt'
    BANK_ACCOUNT = 'ach'
    CREDIT_CARD = 'credit card'
    PREPAID = 'prepaid'
    DEBT = 'Debt'
  end

  class ServiceError < BaseResponse
    parameter :error_type
    parameter :is_retriable
    parameter :error_code
    parameter :reason_text

    class ErrorType
      SYSTEM = 'System'
      BUSINESS = 'Business'
    end
  end

  class ResponseStatus
    SUCCESS = 'Success'
    FAILURE = 'Failure'
  end

  class Token < BaseResponse
    parameter :token_id
    parameter :friendly_name
    parameter :status
    parameter :date_installed, :type => :time
    parameter :caller_installed
    parameter :caller_reference
    parameter :token_type
    parameter :old_token_id
    parameter :payment_reason

    class TokenStatus
      ACTIVE = 'Active'
      INACTIVE = 'Inactive'
    end
  end

  class TokenUsageLimit < BaseResponse
    parameter :count
    parameter :limit
    parameter :last_reset_amount
    parameter :last_reset_count
    parameter :last_reset_time_stamp
  end

  class TransactionResponse < BaseResponse
    parameter :transaction_id
    parameter :status
    parameter :status_detail
    parameter :new_sender_token_usage, :type => TokenUsageLimit

    %w(reserved success failure initiated reinitiated temporary_decline).each do |status_name|
      define_method("#{status_name}?") do
        self.status == Remit::TransactionStatus.const_get(status_name.sub('_', '').upcase)
      end
    end
  end

  class TransactionStatus
    RESERVED          = 'Reserved'
    SUCCESS           = 'Success'
    FAILURE           = 'Failure'
    INITIATED         = 'Initiated'
    REINITIATED       = 'Reinitiated'
    TEMPORARYDECLINE  = 'TemporaryDecline'
  end

  class TokenType
    SINGLE_USE = 'SingleUse'
    MULTI_USE = 'MultiUse'
    RECURRING = 'Recurring'
    UNRESTRICTED = 'Unrestricted'
  end

  class PipelineName
    SINGLE_USE = 'SingleUse'
    MULTI_USE = 'MultiUse'
    RECURRING = 'Recurring'
    RECIPIENT = 'Recipient'
    SETUP_PREPAID = 'SetupPrepaid'
    SETUP_POSTPAID = 'SetupPostpaid'
  end

  class PipelineStatusCode
    CALLER_EXCEPTION  = 'CE'  # problem with your code
    SYSTEM_ERROR      = 'SE'  # system error, try again
    SUCCESS_ABT       = 'SA'  # successful payment with Amazon balance
    SUCCESS_ACH       = 'SB'  # successful payment with bank transfer
    SUCCESS_CC        = 'SC'  # successful payment with credit card
    ABORTED           = 'A'   # user aborted payment
    PAYMENT_METHOD_MISMATCH     = 'PE'  # user does not have payment method requested
    PAYMENT_METHOD_UNSUPPORTED  = 'NP'  # account doesn't support requested payment method
    INVALID_CALLER    = 'NM'  # you are not a valid 3rd party caller to the transaction
    SUCCESS_RECIPIENT_TOKEN_INSTALLED = 'SR'
  end

  module RequestTypes
    class Amount < Remit::Request
      parameter :amount
      parameter :currency_code
    end

    class TemporaryDeclinePolicy < Remit::Request
      parameter :temporary_decline_policy_type
      parameter :implicit_retry_timeout_in_mins
    end

    class DescriptorPolicy < Remit::Request
      parameter :soft_descriptor_type
      parameter :CS_number_of
    end
  end

  class Operation
    PAY             = "Pay"
    REFUND          = "Refund"
    SETTLE          = "Settle"
    SETTLE_DEBT     = "SettleDebt"
    WRITE_OFF_DEBT  = "WriteOffDebt"
    FUND_PREPAID    = "FundPrepaid"
  end
end
