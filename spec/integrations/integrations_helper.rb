ACCESS_KEY = ENV['AWS_ACCESS_KEY'] || ENV['AMAZON_ACCESS_KEY_ID']
SECRET_KEY = ENV['AWS_SECRET_KEY'] || ENV['AMAZON_SECRET_ACCESS_KEY']

unless ACCESS_KEY and SECRET_KEY
  raise RuntimeError, "You must set your AWS_ACCESS_KEY and AWS_SECRET_KEY environment variables to run integration tests"
end

require File.dirname(__FILE__) + '/../spec_helper'
