require 'erb'

require 'remit/common'

module Remit
  module GetPipeline
    class Pipeline
      @parameters = []
      attr_reader :parameters
      
      class << self
        # Create the parameters hash for the subclass.
        def inherited(subclass) #:nodoc:
          subclass.instance_variable_set('@parameters', [])
        end
        
        def parameter(name)
          attr_accessor name
          @parameters << name
        end
        
        def convert_key(key)
          key = key.to_s
          if key == 'return_url'
            :returnURL
          else
            key.gsub(/_(.)/) { $1.upcase }.to_sym
          end
        end
        
        # Returns a hash of all of the parameters for this request, including
        # those that are inherited.
        def parameters #:nodoc:
          (superclass.respond_to?(:parameters) ? superclass.parameters : []) + @parameters
        end
      end
      
      attr_reader :api
      
      parameter :caller_key
      parameter :cobranding_style
      parameter :cobranding_url
      parameter :pipeline_name
      parameter :return_url
      parameter :signature
      parameter :signature_version
      parameter :signature_method
      parameter :version
      parameter :website_description

      def initialize(api, options)
        @api = api
        
        options.each do |k,v|
          self.send("#{k}=", v)
        end
      end

      def url
        uri = URI.parse(@api.pipeline_url)
        
        query = {}
        self.class.parameters.each do |p|
          val = self.send(p)
          
          # Convert Time values to seconds from Epoch
          val = val.to_i if val.is_a?(Time)
          
          query[self.class.convert_key(p.to_s)] = val
        end

        # Remove any unused optional parameters
        query.reject! { |key, value| value.nil? || (value.is_a?(String) && value.empty?) }

        uri.query = SignedQuery.new(@api.pipeline_url, @api.secret_key, query).to_s
        uri.to_s
      end
    end
    
    module ValidityPeriod
      def self.included(base)
        base.class_eval do
          parameter :validity_expiry # Time or seconds from Epoch
          parameter :validity_start # Time or seconds from Epoch
        end
      end
    end

    module UsageLimits
      def self.included(base)
        base.class_eval do
          parameter :usage_limit_type_1
          parameter :usage_limit_period_1
          parameter :usage_limit_value_1
          parameter :usage_limit_type_2
          parameter :usage_limit_period_2
          parameter :usage_limit_value_2
        end
      end
    end

    class RecipientPipeline < Pipeline
      parameter :caller_reference
      parameter :max_fixed_fee
      parameter :max_variable_fee
      parameter :payment_method
      parameter :recipient_pays_fee

      include ValidityPeriod

      def pipeline_name
        Remit::PipelineName::RECIPIENT
      end
    end

    class SenderPipeline < Pipeline
      # I think these should be moved down to the subclasses, or perhaps, all sender pipeline requests
      parameter :address_name
      parameter :address_line_1
      parameter :address_line_2
      parameter :city
      parameter :state
      parameter :zip
      parameter :phone_number

      def pipeline_name
        raise NotImplementedError, 'SenderPipeline is abstract.  Use a concrete subclass.'
      end
    end

    class SingleUsePipeline < SenderPipeline
      parameter :caller_reference
      parameter :collect_shipping_address
      parameter :currency_code
      parameter :discount
      parameter :gift_wrapping
      parameter :handling
      parameter :item_total
      parameter :payment_method
      parameter :payment_reason
      parameter :recipient_token
      parameter :reserve
      parameter :shipping
      parameter :tax
      parameter :transaction_amount

      def pipeline_name
        Remit::PipelineName::SINGLE_USE
      end
    end

    class MultiUsePipeline < SenderPipeline
      parameter :amount_type
      parameter :caller_reference
      parameter :collect_shipping_address
      parameter :currency_code
      parameter :global_amount_limit
      parameter :is_recipient_cobranding
      parameter :payment_method
      parameter :payment_reason
      parameter :recipient_token_list
      parameter :transaction_amount

      include ValidityPeriod
      include UsageLimits

      def pipeline_name
        Remit::PipelineName::MULTI_USE
      end
    end

    class RecurringUsePipeline < SenderPipeline
      parameter :caller_reference
      parameter :collect_shipping_address
      parameter :currency_code
      parameter :is_recipient_cobranding
      parameter :payment_method
      parameter :payment_reason
      parameter :recipient_token
      parameter :recurring_period  
      parameter :transaction_amount

      include ValidityPeriod

      def pipeline_name
        Remit::PipelineName::RECURRING
      end 
    end

    class PostpaidPipeline < SenderPipeline
      parameter :caller_reference_sender
      parameter :caller_reference_settlement
      parameter :collect_shipping_address
      parameter :credit_limit
      parameter :currency_code
      parameter :global_amount_limit
      parameter :payment_method
      parameter :payment_reason

      include ValidityPeriod
      include UsageLimits

      def pipeline_name
        Remit::PipelineName::SETUP_POSTPAID
      end
    end
    
    class PrepaidPipeline < SenderPipeline
      parameter :caller_reference_funding
      parameter :caller_reference_sender
      parameter :collect_shipping_address
      parameter :currency_code
      parameter :funding_amount
      parameter :payment_method
      parameter :payment_reason

      include ValidityPeriod

      def pipeline_name
        Remit::PipelineName::SETUP_PREPAID
      end
    end

    def get_single_use_pipeline(options)
      self.get_pipeline(SingleUsePipeline, options)
    end

    def get_multi_use_pipeline(options)
      self.get_pipeline(MultiUsePipeline, options)
    end

    def get_recipient_pipeline(options)
      self.get_pipeline(RecipientPipeline, options)
    end
    
    def get_recurring_use_pipeline(options)
      self.get_pipeline(RecurringUsePipeline, options)
    end
    
    def get_postpaid_pipeline(options)
      self.get_pipeline(PostpaidPipeline, options)
    end
    
    def get_prepaid_pipeline(options)
      self.get_pipeline(PrepaidPipeline, options)
    end

    def get_pipeline(pipeline_subclass, options)
      pipeline = pipeline_subclass.new(self, {
        :caller_key => @access_key
      }.merge(options))
    end
  end
end
