require File.dirname(__FILE__) + '/units_helper'

describe 'A pipeline', :shared => true do
  before do
    @pipeline_options = {
      :return_url => 'http://example.com/'
    }
  end

  it 'should sign its URL' do
    uri = URI.parse(@pipeline.url)
    pipeline = Remit::SignedQuery.parse(uri, remit.secret_key, uri.query)
    query = Relax::Query.parse(uri)

    pipeline[:awsSignature].should == query[:awsSignature]
  end
end

describe 'A single-use pipeline' do
  it_should_behave_like 'A pipeline'

  before do
    @pipeline_options.merge!({
      :transaction_amount => 10,
      :caller_reference => 'N2PCBEIA5864E27EL7C86PJL1FGUGPBL61QTJJM5GQK265SPEN8ZKIJPMQARDVJK',
      :recipient_token => 'N5PCME5A5Q6FE2QEB7CD64JLGFTUGXBE61HTCJMGGAK2R5IPEQ8EKIVP3QAVD7JP'
    })

    @pipeline = remit.get_single_use_pipeline(@pipeline_options)
  end

  it 'should ignore unused parameters' do
    uri = URI.parse(@pipeline.url)
    query = Relax::Query.parse(uri)

    query[:paymentReason].should be_nil
  end

  it 'should have the right name' do
    @pipeline.pipeline_name.should == Remit::PipelineName::SINGLE_USE
  end
end

describe 'A multi-use pipeline' do
  it_should_behave_like 'A pipeline'

  before do
    @pipeline_options.merge!({
      :transaction_amount => 10,
      :caller_reference => 'N2PCBEIA5864E27EL7C86PJL1FGUGPBL61QTJJM5GQK265SPEN8ZKIJPMQARDVJK',
      :recipient_token_list => 'N5PCME5A5Q6FE2QEB7CD64JLGFTUGXBE61HTCJMGGAK2R5IPEQ8EKIVP3QAVD7JP'
    })

    @pipeline = remit.get_multi_use_pipeline(@pipeline_options)
  end

  it 'should ignore unused parameters' do
    uri = URI.parse(@pipeline.url)
    query = Relax::Query.parse(uri)

    query[:paymentReason].should be_nil
  end

  it 'should have the right name' do
    @pipeline.pipeline_name.should == Remit::PipelineName::MULTI_USE
  end
end

describe 'A recipient pipeline' do
  it_should_behave_like 'A pipeline'

  before do
    @validity_start   = Time.now + (3600 * 24) # 1 day from now
    @validity_expiry  = Time.now + (2600 * 24 * 180) # ~6 months from now

    @pipeline_options.merge!({
      :validity_start => @validity_start,
      :validity_expiry  => @validity_expiry,
      :caller_reference => 'N2PCBEIA5864E27EL7C86PJL1FGUGPBL61QTJJM5GQK265SPEN8ZKIJPMQARDVJK',
      :max_variable_fee => '0.25',
      :recipient_pays_fee => true
    })

    @pipeline = remit.get_recipient_pipeline(@pipeline_options)
  end

  it 'should have the recipient pay marketplace fees' do
    @pipeline.url.should match(/recipientPaysFee=true/)
  end

  it 'should have the right name' do
    @pipeline.pipeline_name.should == Remit::PipelineName::RECIPIENT
  end
end

describe 'A recurring-use pipeline' do
  it_should_behave_like 'A pipeline'

  before do
    @validity_start = Time.now + (3600 * 24)  # 1 day from now
    @validity_expiry = Time.now + (3600 * 24 * 180) # ~6 months from now
    @recurring_period = '1 Month'

    @pipeline_options.merge!({
      :validity_start => @validity_start,
      :validity_expiry => @validity_expiry,
      :recurring_period => @recurring_period,
      :transaction_amount => 10,
      :caller_reference => 'N2PCBEIA5864E27EL7C86PJL1FGUGPBL61QTJJM5GQK265SPEN8ZKIJPMQARDVJK',
      :recipient_token => 'N5PCME5A5Q6FE2QEB7CD64JLGFTUGXBE61HTCJMGGAK2R5IPEQ8EKIVP3QAVD7JP'
    })

    @pipeline = remit.get_recurring_use_pipeline(@pipeline_options)
  end

  it 'should convert times to seconds from epoch' do
    uri = URI.parse(@pipeline.url)
    query = Relax::Query.parse(uri)

    @validity_start.to_i.to_s.should == query[:validityStart]
    @validity_expiry.to_i.to_s.should == query[:validityExpiry]
  end

  it 'should allow time in seconds' do
    options = @pipeline_options.merge({
      :validity_start => @validity_start.to_i,
      :validity_expiry => @validity_expiry.to_i
    })
    @pipeline = remit.get_recurring_use_pipeline(options)

    uri = URI.parse(@pipeline.url)
    query = Relax::Query.parse(uri)

    @validity_start.to_i.to_s.should == query[:validityStart]
    @validity_expiry.to_i.to_s.should == query[:validityExpiry]
  end

  it 'should have the right name' do
    @pipeline.pipeline_name.should == Remit::PipelineName::RECURRING
  end
end

describe 'A postpaid pipeline' do
  it_should_behave_like 'A pipeline'

  before do
    @credit_limit = 100
    @global_amount_limit = 100

    @pipeline_options.merge!({
      :credit_limit => @credit_limit,
      :global_amount_limit => @global_amount_limit
    })

    @pipeline = remit.get_postpaid_pipeline(@pipeline_options)
  end

  it 'should create a PostpaidPipeline' do
    @pipeline.class.should == Remit::GetPipeline::PostpaidPipeline
  end

  it 'should have the right name' do
    @pipeline.pipeline_name.should == Remit::PipelineName::SETUP_POSTPAID
  end
end
