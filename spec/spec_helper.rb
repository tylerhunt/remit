require 'spec'

require File.dirname(__FILE__) + '/../lib/remit'

fail unless ENV.include?('AWS_ACCESS_KEY') and ENV.include?('AWS_SECRET_KEY')

ACCESS_KEY = ENV['AWS_ACCESS_KEY'] unless defined?(ACCESS_KEY)
SECRET_KEY = ENV['AWS_SECRET_KEY'] unless defined?(SECRET_KEY)

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
