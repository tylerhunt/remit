Remit
=====

This API provides access to the Amazon Flexible Payment Service (FPS). After
trying to get the SOAP version of the API written, I began working on this REST
version to provide a cohesive means of access to all of the functionality of
the FPS without having to get dirty dealing with SOAP requests.

I hope you enjoy using it as much as I've enjoyed writing it. I'm interested to
hear what sort of uses you find for it. If you find any bugs, let me know (or
better yet, submit a patch).


Sandbox
-------

Amazon provides a testing environment for the FPS called a sandbox. You may
(and should) use the sandbox while testing your application. It can be enabled
by passing a value of true to the last argument of the API constructor.


Getting Started
---------------

The following example shows how to load up the API, initialize the service, and
make a simple call to get the tokens stored on the account:

    gem 'remit'
    require 'remit'

    ACCESS_KEY = '<your AWS access key>'
    SECRET_KEY = '<your AWS secret key>'

    # connect using the API's sandbox mode
    remit = Remit::API.new(ACCESS_KEY, SECRET_KEY, true)

    response = remit.get_tokens
    puts response.tokens.first.token_id


Using with Rails
----------------

To use Remit in a Rails application, you must first specify a dependency on the
Remit gem in your config/environment.rb file:

    config.gem 'remit', :version => '~> 0.0.1'

Then you should create an initializer to configure your Amazon keys. Create the
file config/initializers/remit.rb with the following contents:

    config_file = File.join(Rails.root, 'config', 'amazon_fps.yml')
    config = YAML.load_file(config_file)[RAILS_ENV].symbolize_keys

    FPS_ACCESS_KEY = config[:access_key]
    FPS_SECRET_KEY = config[:secret_key]

Then create the YAML file config/amazon_fps.yml:

    development: &sandbox
      access_key: <your sandbox access key>
      secret_key: <your sandbox secret key>

    test:
      <<: *sandbox
    
    production:
      access_key: <your access key>
      secret_key: <your secret key>

To instantiate and use the Remit API in your application, you could define a
method in your ApplicationController like this:

    def remit
      @remit ||= begin
        sandbox = !Rails.env.production?
        Remit::API.new(FPS_ACCESS_KEY, FPS_SECRET_KEY, sandbox)
      end
    end


Sites Using Remit
-----------------

The following production sites are currently using Remit:

  * http://www.storenvy.com/
  * http://www.obsidianportal.com/


Copyright (c) 2007-2009 Tyler Hunt, released under the MIT license
