# Scraped and categorized from http://docs.amazonwebservices.com/AmazonFPS/\
# 2007-01-08/FPSDeveloperGuide/index.html?ErrorCodesTable.html. You can use
# these categories to specify default error handling in your application such
# as asking users to retry or sending an exception email.
module Remit::ErrorCodes
  class << self
    def sender_error?(code)
      SENDER.include? code.to_sym
    end

    def recipient_error?(code)
      RECIPIENT.include? code.to_sym
    end

    def caller_error?(code)
      CALLER.include?(code.to_sym)
    end

    def amazon_error?(code)
      AMAZON.include? code.to_sym
    end

    def api_error?(code)
      API.include? code.to_sym
    end

    def unknown_error?(code)
      UNKNOWN.include? code.to_sym
    end
  end

  SENDER = [
    :InactiveAccount_Sender, # The sender's account is in suspended or closed state.
    :InactiveInstrument, # The payment instrument used for this transaction is no longer active.
    :InstrumentExpired, # The prepaid or the postpaid instrument has expired.
    :InstrumentNotActive, # The prepaid or postpaid instrument used in the transaction is not active.
    :InvalidAccountState_Sender, # Sender account cannot participate in the transaction.
    :InvalidInstrumentForAccountType, # The sender account can use only credit cards
    :InvalidInstrumentState, # The prepaid or credit instrument should be active
    :InvalidTokenId_Sender, # The send token specified is either invalid or canceled or the token is not active.
    :PaymentInstrumentNotCC, # The payment method specified in the transaction is not a credit card. You can only use a credit card for this transaction.
    :PaymentInstrumentMissing, # There needs to be a payment instrument defined in the token which defines the payment method.
    :TokenNotActive_Sender, # The sender token is canceled.
    :UnverifiedAccount_Sender, # The sender's account must have a verified U.S. credit card or a verified U.S bank account before this transaction can be initiated
    :UnverifiedBankAccount, # A verified bank account should be used for this transaction
    :UnverifiedEmailAddress_Sender, # The sender account must have a verified e-mail address for this payment
  ]

  RECIPIENT = [
    :InactiveAccount_Recipient, # The recipient's account is in suspended or closed state.
    :InvalidAccountState_Recipient, # Recipient account cannot participate in the transaction
    :InvalidRecipientRoleForAccountType, # The recipient account is not allowed to receive payments
    :InvalidRecipientForCCTransaction, # This account cannot receive credit card payments.
    :InvalidTokenId_Recipient, # The recipient token specified is either invalid or canceled.
    :TokenNotActive_Recipient, # The recipient token is canceled.
    :UnverifiedAccount_Recipient, # The recipient's account must have a verified bank account or a credit card before this transaction can be initiated.
    :UnverifiedEmailAddress_Recipient, # The recipient account must have a verified e-mail address for receiving payments.
  ]

  CALLER = [
    :InactiveAccount_Caller, # The caller's account is in suspended or closed state.
    :InvalidAccountState_Caller, # The caller account cannot participate in the transaction
    :InvalidTokenId_Caller, # The caller token specified is either invalid or canceled or the specified token is not active.
    :TokenNotActive_Caller, # The caller token is canceled.
    :UnverifiedEmailAddress_Caller, # The caller account must have a verified e-mail address
  ]

  AMAZON = [
    :InternalError # A retriable error that happens due to some transient problem in the system.
  ]

  # bad syntax or logic
  API = [
    :AmountOutOfRange, # The transaction amount is more than the allowed range.
    :BadRule, # One of the GK constructs is not well defined
    :CannotSpecifyUsageForSingleUseToken, # Token usages cannot be specified for a single use token.
    :ConcurrentModification, # A retriable error can happen due to concurrent modification of data by two processes.
    :DuplicateRequest, # A different request associated with this caller reference already exists.
    :IncompatibleTokens, # The transaction could not be completed because the tokens have incompatible payment instructions.
    :InstrumentAccessDenied, # The external calling application is not the recipient for this postpaid or prepaid instrument. The caller should be the liability holder
    :InvalidCallerReference, # The CallerReferece does not have a token associated with it.
    :InvalidDateRange, # The end date specified is before the start date or the start date is in the future.
    :InvalidEvent, # The event specified was not subscribed using the SubscribeForCallerNotification operation.
    :InvalidParams, # One or more parameters in the request is invalid.
    :InvalidPaymentInstrument, # The payment method used in the transaction is invalid.
    :InvalidPaymentMethod, # Payment method specified in the GK construct is invalid.
    :InvalidSenderRoleForAccountType, # This token cannot be used for this operation.
    :InvalidTokenId, # The token that you are trying to cancel was not installed by you.
    :InvalidTokenType, # Invalid operation performed on the token. Example, getting the token usage information on a single use token.
    :InvalidTransactionId, # The specified transaction could not be found or the caller did not execute the transaction or this is not a Pay or Reserve call.
    :InvalidTransactionState, # The transaction is not completed or it has been temporarily failed.
    :InvalidUsageDuration, # The duration cannot be less than one hour.
    :InvalidUsageLimitCount, # The usage count is null or empty.
    :InvalidUsageStartTime, # The start time specified for the token is not valid.
    :InvalidUsageType, # The usage type specified is invalid.
    :OriginalTransactionIncomplete, # The original transaction is still in progress.
    :OriginalTransactionFailed, # The original transaction has failed
    :PaymentMethodNotDefined, # Payment method is not defined in the transaction.
    :RefundAmountExceeded, # The refund amount is more than the refundable amount.
    :SameTokenIdUsedMultipleTimes, # This token is already used in earlier transactions.
    :SenderNotOriginalRecipient, # The sender in the refund transaction is not the recipient of the original transaction.
    :SettleAmountGreaterThanReserveAmount, # The amount being settled is greater than the reserved amount.
    :TransactionDenied, # This transaction is not allowed.
    :TransactionExpired, # Returned when the Caller attempts to explicitly retry a transaction that is temporarily declined and is in queue for implicit retry.
    :TransactionFullyRefundedAlready, # The complete refund for this transaction is already completed
    :TransactionTypeNotRefundable, # You cannot refund this transaction.
    :TokenAccessDenied, # Permission is denied to cancel the token.
    :TokenUsageError, # The token usage limit is exceeded.
    :UsageNotDefined, # For a multi-use token or a recurring token the usage limits are not specified in the GateKeeper text.
  ]

  # these errors don't specify who is at fault
  UNKNOWN = [
    :InvalidAccountState, # The account is either suspended or closed. Payment instructions cannot be installed on this account.
    :InsufficientBalance, # The sender, caller, or recipient's account balance has insufficient funds to complete the transaction.
    :AccountLimitsExceeded, # The spending or the receiving limit on the account is exceeded
  ]
end
