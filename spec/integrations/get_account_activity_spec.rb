require File.dirname(__FILE__) + '/integrations_helper'

describe 'a GetAccountActivity call' do
  it_should_behave_like 'a successful response'

  before(:all) do
    request = Remit::GetAccountActivity::Request.new
    request.start_date = Date.today - 7
    @response = remit.get_account_activity(request)
  end

  it "has results" do
    @response.get_account_activity_result.should_not be_nil
  end

  it 'should have a collection of transactions' do
    @response.get_account_activity_result.transactions.class.should == Array
  end

  it 'should have a transaction with all of its values set' do
    transaction = @response.get_account_activity_result.transactions.first
    #Depending on the data in the sandbox used there may or may not actually be data here:
    if transaction
      transaction.caller_name.should_not be_empty
      transaction.caller_transaction_date.should_not be_nil
      transaction.date_completed.should_not be_nil
      transaction.date_received.should_not be_nil
      transaction.error_code.should eql("")
      #transaction.error_detail.should eql("")
      #transaction.error_message.should eql("")
      transaction.fees.should_not be_nil
      transaction.fps_operation.should_not be_empty
      transaction.recipient_name.should_not be_empty
      transaction.sender_name.should_not be_empty
      transaction.sender_token_id.should_not be_nil #some transactions have '' here.
      transaction.status_code.should_not be_empty
      transaction.transaction_amount.should_not be_nil
      transaction.transaction_id.should_not be_empty
      transaction.transaction_parts.should_not be_empty
    end
  end
end
