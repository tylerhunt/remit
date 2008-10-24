require 'rubygems'
require 'spec'

require File.dirname(__FILE__) + '/../lib/remit'

describe 'a successful response', :shared => true do
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
