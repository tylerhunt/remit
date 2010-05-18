require File.dirname(__FILE__) + '/units_helper'

describe "the GetTransaction API" do
  describe "a successful response" do
    it_should_behave_like 'a successful response'
    
    before do
      doc = <<-XML
        <GetAccountActivityResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <GetAccountActivityResult>
            <BatchSize>5</BatchSize>
            <Transaction>
              <TransactionId>14GN2BUHUAV4KG5S8USHN79PQH1NGN5ADK4</TransactionId>
              <CallerTransactionDate>
                2009-10-07T01:37:54.765-07:00
              </CallerTransactionDate>
              <DateReceived>2009-10-07T01:38:11.262-07:00</DateReceived>
              <DateCompleted>2009-10-07T01:38:12.857-07:00</DateCompleted>
              <TransactionAmount>
                <CurrencyCode>USD</CurrencyCode>
                <Value>1.000000</Value>
              </TransactionAmount>
              <FPSOperation>FundPrepaid</FPSOperation>
              <TransactionStatus>Success</TransactionStatus>
              <StatusMessage>
                The transaction was successful and the payment instrument was charged.
              </StatusMessage>
              <StatusCode>Success</StatusCode>
              <TransactionPart>
                <Role>Recipient</Role>
                <Name>Test Business</Name>
                <FeesPaid>
                  <CurrencyCode>USD</CurrencyCode>
                  <Value>0.100000</Value>
                </FeesPaid>
              </TransactionPart>
              <TransactionPart>
                <Role>Caller</Role>
                <Name>Test Business</Name>
                <Reference>CallerReference10</Reference>
                <Description>MyWish</Description>
                <FeesPaid>
                  <CurrencyCode>USD</CurrencyCode>
                  <Value>0.000000</Value>
                </FeesPaid>
              </TransactionPart>
              <PaymentMethod>CC</PaymentMethod>
              <SenderName>Test Business</SenderName>
              <CallerName>Test Business</CallerName>
              <RecipientName>Test Business</RecipientName>
              <FPSFees>
                <CurrencyCode>USD</CurrencyCode>
                <Value>0.100000</Value>
              </FPSFees>
              <Balance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>7.400000</Value>
              </Balance>
              <SenderTokenId>
         563INMLCG3ZJJ4L1I7BB31MN2FBQUCVXNTDRTCT5A2DJDXG6LNZ7KSNUJPI7TVIF
              </SenderTokenId>
            </Transaction>
            <Transaction>
              <TransactionId>14GN1O5992IEOB3ELM1SCUFTSOQ3C6S7NR2</TransactionId>
              <CallerTransactionDate>2009-10-07T01:27:21.469-07:00</CallerTransactionDate>
              <DateReceived>2009-10-07T01:27:22.793-07:00</DateReceived>
              <DateCompleted>2009-10-07T01:27:23.335-07:00</DateCompleted>
              <TransactionAmount>
                <CurrencyCode>USD</CurrencyCode>
                <Value>4.000000</Value>
              </TransactionAmount>
              <FPSOperation>Pay</FPSOperation>
              <TransactionStatus>Success</TransactionStatus>
              <StatusMessage>
              The transaction was successful and the payment instrument was charged.
              </StatusMessage>
              <StatusCode>Success</StatusCode>
              <TransactionPart>
                <Role>Recipient</Role>
                <Name>Test Business</Name>
                <Reference>Prepaid Digital Download - 1254904041469</Reference>
                <Description>Prepaid Digital Download</Description>
                <FeesPaid>
                  <CurrencyCode>USD</CurrencyCode>
                  <Value>0.000000</Value>
                </FeesPaid>
              </TransactionPart>
              <TransactionPart>
                <Role>Caller</Role>
                <Name>Test Business</Name>
                <Reference>Prepaid Digital Download - 1254904034205</Reference>
                <Description>
                  Prepaid Digital Download - payment for mp3 from digital.
                </Description>
                <FeesPaid>
                  <CurrencyCode>USD</CurrencyCode>
                  <Value>0.000000</Value>
                </FeesPaid>
              </TransactionPart>
              <PaymentMethod>Prepaid</PaymentMethod>
              <SenderName>Test Business</SenderName>
              <CallerName>Test Business</CallerName>
              <RecipientName>Test Business</RecipientName>
              <FPSFees>
                <CurrencyCode>USD</CurrencyCode>
                <Value>0</Value>
              </FPSFees>
              <Balance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>6.500000</Value>
              </Balance>
              <SenderTokenId>
                513I1MGCG6ZZJ49157BZ3EMNJFAQU6V9NTSRUCTEANDJ3X46LGZNKSJUVPIXTPID
              </SenderTokenId>
              <RecipientTokenId>
                D639FT4TMP4QK9UBH6PAK2WAXGHDZSBUX3UJSGVX3LEFVGU7XDQXMENL4OGVZEGB
              </RecipientTokenId>
            </Transaction>
            <Transaction>
              <TransactionId>14GN1NHHN489BFGH6D8BMGT8NLSR2DJ4PNK</TransactionId>
              <CallerTransactionDate>
                2009-10-07T01:26:58.190-07:00
              </CallerTransactionDate>
              <DateReceived>2009-10-07T01:27:02.583-07:00</DateReceived>
              <DateCompleted>2009-10-07T01:27:04.435-07:00</DateCompleted>
              <TransactionAmount>
                <CurrencyCode>USD</CurrencyCode>
                <Value>5.000000</Value>
              </TransactionAmount>
              <FPSOperation>FundPrepaid</FPSOperation>
              <TransactionStatus>Success</TransactionStatus>
              <StatusMessage>
                The transaction was successful and the payment instrument was charged.
              </StatusMessage>
              <StatusCode>Success</StatusCode>
              <TransactionPart>
                <Role>Caller</Role>
                <Name>Test Business</Name>
                <Reference>Prepaid Digital Download - 1254903995419</Reference>
                <FeesPaid>
                  <CurrencyCode>USD</CurrencyCode>
                  <Value>0.000000</Value>
                </FeesPaid>
              </TransactionPart>
              <TransactionPart>
                <Role>Recipient</Role>
                <Name>Test Business</Name>
                <FeesPaid>
                  <CurrencyCode>USD</CurrencyCode>
                  <Value>0.300000</Value>
                </FeesPaid>
              </TransactionPart>
              <PaymentMethod>CC</PaymentMethod>
              <SenderName>Test Business</SenderName>
              <CallerName>Test Business</CallerName>
              <RecipientName>Test Business</RecipientName>
              <FPSFees>
                <CurrencyCode>USD</CurrencyCode>
                <Value>0.300000</Value>
              </FPSFees>
              <Balance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>6.500000</Value>
              </Balance>
              <SenderTokenId>
                513ISM2CGDZPJ4S1D7BH3HMNIFCQUAVNNTQRXCTHAUDJLXV6LMZLKSTUKPITTXIV
              </SenderTokenId>
            </Transaction>
            <Transaction>
              <TransactionId>14GMNT2PDVUJA18L44TO4DIFJEJRF9LTV2T</TransactionId>
              <CallerTransactionDate>
                2009-10-06T22:35:02.031-07:00
              </CallerTransactionDate>
              <DateReceived>2009-10-06T22:35:18.317-07:00</DateReceived>
              <DateCompleted>2009-10-06T22:35:19.332-07:00</DateCompleted>
              <TransactionAmount>
                <CurrencyCode>USD</CurrencyCode>
                <Value>1.000000</Value>
              </TransactionAmount>
              <FPSOperation>Refund</FPSOperation>
              <TransactionStatus>Success</TransactionStatus>
              <StatusMessage>
                The transaction was successful and the payment instrument was charged.
              </StatusMessage>
              <StatusCode>Success</StatusCode>
              <TransactionPart>
                <Role>Caller</Role>
                <Name>Test Business</Name>
                <Reference>CallerReference09</Reference>
                <FeesPaid>
                  <CurrencyCode>USD</CurrencyCode>
                  <Value>0.000000</Value>
                </FeesPaid>
              </TransactionPart>
              <TransactionPart>
                <Role>Sender</Role>
                <Name>Test Business</Name>
                <FeesPaid>
                  <CurrencyCode>USD</CurrencyCode>
                  <Value>-0.100000</Value>
                </FeesPaid>
              </TransactionPart>
              <PaymentMethod>CC</PaymentMethod>
              <SenderName>Test Business</SenderName>
              <CallerName>Test Business</CallerName>
              <RecipientName>Test Business</RecipientName>
              <FPSFees>
                <CurrencyCode>USD</CurrencyCode>
                <Value>-0.100000</Value>
              </FPSFees>
              <Balance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>1.800000</Value>
              </Balance>
            </Transaction>
            <Transaction>
              <TransactionId>14GMNRDSJ6TJTNDUTOUA917PIFJDSGNB2JP</TransactionId>
              <CallerTransactionDate>
                2009-10-06T22:34:24.053-07:00
              </CallerTransactionDate>
              <DateReceived>2009-10-06T22:34:24.147-07:00</DateReceived>
              <DateCompleted>2009-10-06T22:34:25.223-07:00</DateCompleted>
              <TransactionAmount>
                <CurrencyCode>USD</CurrencyCode>
                <Value>1.000000</Value>
              </TransactionAmount>
              <FPSOperation>Pay</FPSOperation>
              <TransactionStatus>Success</TransactionStatus>
              <StatusMessage>
                The transaction was successful and the payment instrument was charged.
              </StatusMessage>
              <StatusCode>Success</StatusCode>
              <TransactionPart>
                <Role>Recipient</Role>
                <Name>Test Business</Name>
                <Description>SubscriptionTesting</Description>
                <FeesPaid>
                  <CurrencyCode>USD</CurrencyCode>
                  <Value>0.100000</Value>
                </FeesPaid>
              </TransactionPart>
              <TransactionPart>
                <Role>Caller</Role>
                <Name>Test Business</Name>
                <Reference>63314e32-d6b0-4abd-a0ab-7b89717ba5cb</Reference>
                <FeesPaid>
                  <CurrencyCode>USD</CurrencyCode>
                  <Value>0.000000</Value>
                </FeesPaid>
              </TransactionPart>
              <PaymentMethod>CC</PaymentMethod>
              <SenderName>Test Business</SenderName>
              <CallerName>Test Business</CallerName>
              <RecipientName>Test Business</RecipientName>
              <FPSFees>
                <CurrencyCode>USD</CurrencyCode>
                <Value>0.100000</Value>
              </FPSFees>
              <Balance>
                <CurrencyCode>USD</CurrencyCode>
                <Value>2.700000</Value>
              </Balance>
              <SenderTokenId>
                533I1M9CGUZ9J4M197BM3LMNKFVQUFVFNT5RRCT2ACDJBXV6LRZ6KSRUSPI6T3I3
              </SenderTokenId>
              <RecipientTokenId>
                D139MTVTMK4CK9QB26PKKLWA1GHDZGBGX3SJLGVU37EFUGJ7XVQIMETLSOGAZJGV
              </RecipientTokenId>
            </Transaction>
          </GetAccountActivityResult>
          <ResponseMetadata>
            <RequestId>87e1570a-ef8c-4846-8265-74d07a6a83fb:0</RequestId>
          </ResponseMetadata>
        </GetAccountActivityResponse>
      XML
      
      @response = Remit::GetAccountActivity::Response.new(doc)
    end
    
    it "has results" do
      @response.get_account_activity_result.should_not be_nil
    end
    
    describe "the result" do
      before do
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
      
      it "should have batch_size equal to transactions.size" do
        @activity.transactions.size.should == @activity.batch_size.to_i
      end
      
      it "should have start_time_for_next_transaction" do
        @activity.start_time_for_next_transaction.should_not be_nil
      end
      
      
      
#      it "should have transaction_status" do
#        @transaction.transaction_status.should == "Success"
#      end
#      
#      it "should have status_code" do
#        @transaction.status_code.should == "Success"
#      end
#      
#      it "should have status_message" do
#        @transaction.status_message.should_not be_nil
#      end
      
      
      #
      #      it "reports the transaction's new status" do
      #        @result.transaction_status.should == 'Success'
      #      end
    end
  end
end