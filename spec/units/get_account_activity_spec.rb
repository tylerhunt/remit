require File.dirname(__FILE__) + '/units_helper'

describe "the GetAccountActivity API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before(:all) do
      doc = File.read("spec/mocks/GetAccountActivityResponse.xml")
      
      @response = Remit::GetAccountActivity::Response.new(doc)
    end
    
    it "has results" do
      @response.get_account_activity_result.should_not be_nil
    end
    
    describe "the result" do
      before(:all) do
        @activity = @response.get_account_activity_result
      end
      
      it "should have transactions" do
        @activity.transactions.should_not be_nil
      end
      
      it "should have transactions" do
        @activity.transactions.size.should_not == 0
      end
      
      it "should have batch_size" do
        @activity.batch_size.should_not be_nil
      end
            
      it "should have start_time_for_next_transaction" do
        @activity.start_time_for_next_transaction.should_not be_nil
      end
      
      describe "a transaction" do
        before(:all) do
          @transaction = @activity.transactions.first
        end
        it "should have transaction_status" do
          @transaction.transaction_status.should == "string"
        end

        it "should have status_code" do
          @transaction.status_code.should == "string"
        end

        it "should have status_message" do
          @transaction.status_message.should_not be_nil
        end

      end

    end
  end
end
