require File.dirname(__FILE__) + '/units_helper'

describe "the GetTokenUsage API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetTokenUsageResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
           <GetTokenUsageResult>
               <TokenUsageLimits>
                   <Amount>
                      <CurrencyCode>USD</CurrencyCode>
                      <Value>10.000000</Value>
                   </Amount>
                   <LastResetAmount>
                       <CurrencyCode>USD</CurrencyCode>
                       <Value>0.000000</Value>
                    </LastResetAmount>
                    <LastResetTimestamp>
                      2008-01-01T02:00:00.000-08:00
                    </LastResetTimestamp>
               </TokenUsageLimits>
               <TokenUsageLimits>
                   <Count>1</Count>
                   <LastResetCount>0</LastResetCount>
                   <LastResetTimestamp>
                    2008-01-01T02:00:00.000-08:00
                   </LastResetTimestamp>
               </TokenUsageLimits>
           </GetTokenUsageResult>
           <ResponseMetadata>
               <RequestId>9faeed71-9362-4eb8-9431-b99e92b441ee:0</RequestId>
           </ResponseMetadata>
        </GetTokenUsageResponse>
      XML
      
      @response = Remit::GetTokenUsage::Response.new(doc)
    end
    
    it "has metadata" do
      @response.response_metadata.should_not be_nil
    end
    
    it "has results" do
      @response.get_token_usage_result.should_not be_nil
    end
    
    
  end
end