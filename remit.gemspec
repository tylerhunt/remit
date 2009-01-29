# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{remit}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tyler Hunt"]
  s.date = %q{2009-01-29}
  s.email = %q{tyler@tylerhunt.com}
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.files = ["lib/remit", "lib/remit/cancel_token.rb", "lib/remit/common.rb", "lib/remit/data_types.rb", "lib/remit/discard_results.rb", "lib/remit/error_codes.rb", "lib/remit/fund_prepaid.rb", "lib/remit/get_account_activity.rb", "lib/remit/get_account_balance.rb", "lib/remit/get_all_credit_instruments.rb", "lib/remit/get_all_prepaid_instruments.rb", "lib/remit/get_debt_balance.rb", "lib/remit/get_outstanding_debt_balance.rb", "lib/remit/get_payment_instruction.rb", "lib/remit/get_pipeline.rb", "lib/remit/get_prepaid_balance.rb", "lib/remit/get_results.rb", "lib/remit/get_token_by_caller.rb", "lib/remit/get_token_usage.rb", "lib/remit/get_tokens.rb", "lib/remit/get_total_prepaid_liability.rb", "lib/remit/get_transaction.rb", "lib/remit/install_payment_instruction.rb", "lib/remit/ipn_request.rb", "lib/remit/pay.rb", "lib/remit/pipeline_response.rb", "lib/remit/refund.rb", "lib/remit/reserve.rb", "lib/remit/retry_transaction.rb", "lib/remit/settle.rb", "lib/remit/settle_debt.rb", "lib/remit/subscribe_for_caller_notification.rb", "lib/remit/unsubscribe_for_caller_notification.rb", "lib/remit/write_off_debt.rb", "lib/remit.rb", "spec/integrations/get_account_activity_spec.rb", "spec/integrations/get_tokens_spec.rb", "spec/units/get_pipeline_spec.rb", "spec/units/get_results_spec.rb", "spec/units/ipn_request_spec.rb", "spec/units/pay_spec.rb", "spec/integrations/integrations_helper.rb", "spec/spec_helper.rb", "spec/units/units_helper.rb", "README", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://tylerhunt.com/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{remit}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{An API for using the Amazon Flexible Payment Service (FPS).}
  s.test_files = ["spec/integrations/get_account_activity_spec.rb", "spec/integrations/get_tokens_spec.rb", "spec/units/get_pipeline_spec.rb", "spec/units/get_results_spec.rb", "spec/units/ipn_request_spec.rb", "spec/units/pay_spec.rb", "spec/integrations/integrations_helper.rb", "spec/spec_helper.rb", "spec/units/units_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<relax>, [">= 0.0.5"])
    else
      s.add_dependency(%q<relax>, [">= 0.0.5"])
    end
  else
    s.add_dependency(%q<relax>, [">= 0.0.5"])
  end
end
