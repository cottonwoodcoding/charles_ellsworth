if Rails.env.development?
  begin
    braintree_config = YAML.load_file('config/braintree.yml')
    braintree_config.each { |key, value| ENV[key] = value }
  rescue
    raise "There is no braintree config"
  end
end

BraintreeRails::Configuration.logger = Logger.new('log/braintree.log') if Rails.env.development?
BraintreeRails::Configuration.merchant_id = ENV['braintree_merchant_id']
BraintreeRails::Configuration.public_key = ENV['braintree_public_key']
BraintreeRails::Configuration.private_key = ENV['braintree_private_key']
BraintreeRails::Configuration.client_side_encryption_key = ENV['braintree_client_side_encryption_key']

if Rails.env.production?
  BraintreeRails::Configuration.environment = :production
else
  BraintreeRails::Configuration.environment = :sandbox
end
