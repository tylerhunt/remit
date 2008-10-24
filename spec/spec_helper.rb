require 'spec'

require File.dirname(__FILE__) + '/../lib/remit'

ACCESS_KEY = ENV['AWS_ACCESS_KEY'] || ENV['AMAZON_ACCESS_KEY_ID']
SECRET_KEY = ENV['AWS_SECRET_KEY'] || ENV['AMAZON_SECRET_ACCESS_KEY']

unless ACCESS_KEY and SECRET_KEY
  raise RuntimeError, "You must set your AWS_ACCESS_KEY and AWS_SECRET_KEY environment variables to run these tests"
end

describe 'a successful request', :shared => true do
  before(:all) do
    @remit = Remit::API.new(ACCESS_KEY, SECRET_KEY, true)
  end

  it 'should return success' do
    @response.status.should eql('Success')
  end

  it 'should not have any errors' do
    @response.errors.should be_nil
  end

  it 'should have a request ID' do
    @response.request_id.should_not be_nil
  end
end
