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
          key.to_s.gsub(/_(.)/) { $1.upcase }.to_sym
        end
        
        # Returns a hash of all of the parameters for this request, including
        # those that are inherited.
        def parameters #:nodoc:
          (superclass.respond_to?(:parameters) ? superclass.parameters : []) + @parameters
        end
      end
      
      attr_reader :api
      
      parameter :pipeline_name
      parameter :return_url
      parameter :caller_key
      parameter :version
      parameter :address_name
      parameter :address_line_1
      parameter :address_line_2
      parameter :city
      parameter :state
      parameter :zip
      parameter :country
      parameter :phone_number

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
    
    class SingleUsePipeline < Pipeline
      parameter :caller_reference
      parameter :payment_reason
      parameter :payment_method
      parameter :transaction_amount
      parameter :recipient_token
      
      def pipeline_name
        Remit::PipelineName::SINGLE_USE
      end
    end
    
    class MultiUsePipeline < Pipeline
      parameter :caller_reference
      parameter :payment_reason
      parameter :recipient_token_list
      parameter :amount_type
      parameter :transaction_amount
      parameter :validity_start
      parameter :validity_expiry
      parameter :payment_method
      parameter :global_amount_limit
      parameter :usage_limit_type_1
      parameter :usage_limit_period_1
      parameter :usage_limit_value_1
      parameter :usage_limit_type_2
      parameter :usage_limit_period_2
      parameter :usage_limit_value_2
      parameter :is_recipient_cobranding
      
      def pipeline_name
        Remit::PipelineName::MULTI_USE
      end
    end
    
    class RecipientPipeline < Pipeline
      parameter :caller_reference
      parameter :validity_start # Time or seconds from Epoch
      parameter :validity_expiry # Time or seconds from Epoch
      parameter :payment_method
      parameter :recipient_pays_fee
      parameter :caller_reference_refund
      parameter :max_variable_fee
      parameter :max_fixed_fee
      
      def pipeline_name
        Remit::PipelineName::RECIPIENT
      end
    end

    class RecurringUsePipeline < Pipeline
      parameter :caller_reference
      parameter :payment_reason
      parameter :recipient_token
      parameter :transaction_amount
      parameter :validity_start # Time or seconds from Epoch
      parameter :validity_expiry # Time or seconds from Epoch
      parameter :payment_method
      parameter :recurring_period  
      
      def pipeline_name
        Remit::PipelineName::RECURRING
      end 
    end
    
    class PostpaidPipeline < Pipeline
      parameter :caller_reference_sender
      parameter :caller_reference_settlement
      parameter :payment_reason
      parameter :payment_method
      parameter :validity_start # Time or seconds from Epoch
      parameter :validity_expiry # Time or seconds from Epoch
      parameter :credit_limit
      parameter :global_amount_limit
      parameter :usage_limit_type1
      parameter :usage_limit_period1
      parameter :usage_limit_value1
      parameter :usage_limit_type2
      parameter :usage_limit_period2
      parameter :usage_limit_value2
      
      def pipeline_name
        Remit::PipelineName::SETUP_POSTPAID
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
    
    def get_pipeline(pipeline_subclass, options)
      pipeline = pipeline_subclass.new(self, {
        :caller_key => @access_key
      }.merge(options))
    end
  end
end
