# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
require 'securerandom'
def secure_token
	token_file = Rails.root.join('.secret')
	if File.exist?(token_file)
# Use the existing token.
		File.read(token_file).chomp
	else
# Generate a new token and store it in token_file.
		token = SecureRandom.hex(64)
		File.write(token_file, token)
		token
	end
end
SampleApp2::Application.config.secret_key_base = 'd98922ad8cfb330f781258794e91793a190d461d58614bc4c54ed5617863761b8fb3b0cf980934bddf7ad8538e1616f14dcf857c92d077d5bc882a5f5dd641ab'
