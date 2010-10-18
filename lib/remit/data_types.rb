require 'rubygems'
require 'relax'

require 'remit/common'

module Remit
  class Amount < BaseResponse
    parameter :currency_code
    parameter :value, :type => :float
  end

  class TemporaryDeclinePolicy < BaseResponse
    parameter :temporary_decline_policy_type
    parameter :implicit_retry_timeout_in_mins
  end

  class DescriptorPolicy < BaseResponse
    parameter :soft_descriptor_type
    parameter :CS_owner
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
    BALANCE_aFER = 'abt'
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
    parameter :token_status
    parameter :date_installed, :type => :time
    #parameter :caller_installed
    parameter :caller_reference
    parameter :token_type
    parameter :old_token_id
    #parameter :payment_reason

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
  
  class TransactionPart < Remit::BaseResponse
    parameter :account_id
    parameter :role
    parameter :name
    parameter :reference
    parameter :description
    parameter :fee_paid, :type => Amount
  end
    
  class Transaction < BaseResponse
    
    parameter :caller_name
    parameter :caller_reference
    parameter :caller_description
    parameter :caller_transaction_date, :type => :time
    parameter :date_completed, :type => :time
    parameter :date_received, :type => :time
    parameter :error_code
    parameter :error_message
    parameter :fees, :type => Amount
    parameter :fps_fees_paid_by, :element=>"FPSFeesPaidBy"
    parameter :fps_operation, :element=>"FPSOperation"
    parameter :meta_data
    parameter :payment_method
    parameter :recipient_name
    parameter :recipient_email
    parameter :recipient_token_id
    parameter :related_transactions
    parameter :sender_email
    parameter :sender_name
    parameter :sender_token_id
    parameter :transaction_status
    parameter :status_code
    parameter :status_history
    parameter :status_message
    parameter :transaction_amount, :type => Amount
    parameter :transaction_id
    parameter :transaction_parts, :collection => TransactionPart, :element=>"TransactionPart"
  end

  class TransactionResponse < BaseResponse
    parameter :transaction_id
    parameter :transaction_status

    %w(cancelled failure pending reserved success).each do |status_name|
      define_method("#{status_name}?") do
        self.transaction_status == Remit::TransactionStatus.const_get(status_name.sub('_', '').upcase)
      end
    end
  end

  class TransactionStatus
    #For IPN operations these strings are upcased.  For Non-IPN operations they are not upcased
    CANCELLED         = 'Cancelled'
    FAILURE           = 'Failure'
    PENDING           = 'Pending'
    RESERVED          = 'Reserved'
    SUCCESS           = 'Success'
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
    EDIT_TOKEN = 'EditToken'
  end

  class PipelineStatusCode
    CALLER_EXCEPTION  = 'CE'  # problem with your code
    SYSTEM_ERROR      = 'SE'  # system error, try again
    SUCCESS_UNCHANGED = 'SU'  # edit token pipeline finished, but token is unchanged
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
      parameter :value
      parameter :currency_code
    end
    
    class TemporaryDeclinePolicy < Remit::Request
      parameter :temporary_decline_policy_type
      parameter :implicit_retry_timeout_in_mins
    end

    class DescriptorPolicy < Remit::Request
      parameter :soft_descriptor_type
      parameter :CS_owner
    end

  end
  
  class SoftDescriptorType
    STATIC = 'Static'
    DYNAMIC = 'Dynamic'
  end

  #MarketplaceRefundPolicy is available in these APIs:
  # Amazon FPS Advanced Quick Start
  # Amazon FPS Marketplace Quick Start
  # Amazon FPS Aggregated Payments Quick Start
  # i.e. Not Basic Quick Start
  #It really should be listed under Enumerated DataTypes:
  #MarketplaceTxnOnly      Caller refunds his fee to the recipient.             String
  #MasterAndMarketplaceTxn Caller and Amazon FPS refund their fees to the       String
  #                        sender, and the recipient refunds his amount
  #MasterTxnOnly           Caller does not refund his fee. Amazon FPS           String
  #                        refunds its fee and the recipient refunds his amount
  #                        plus the caller's fee to the sender.
  class MarketplaceRefundPolicy
    POLICY = {
      :marketplace_txn_only => 'MarketplaceTxnOnly',
      :master_and_marketplace_txn => 'MasterAndMarketplaceTxn',
      :master_txn_only => 'MasterTxnOnly' #default if not specified, set by Amazon FPS
    }
  end

  class TemporaryDeclinePolicyType
    EXPLICIT_RETRY = 'ExplicitRetry'
    IMPLICIT_RETRY = 'ImplicitRetry'
    FAILURE = 'Failure'
  end
    
  class Operation
    PAY             = "Pay"
    REFUND          = "Refund"
    SETTLE          = "Settle"
    SETTLE_DEBT     = "SettleDebt"
    WRITE_OFF_DEBT  = "WriteOffDebt"
    FUND_PREPAID    = "FundPrepaid"
  end
  
  class VerifySignatureResult < BaseResponse
    parameter :verification_status
  end
end
