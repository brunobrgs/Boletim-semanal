# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_boletim_session',
  :secret      => 'bdadaa3459ff97a9a3a8ebb41ff1292ce08b533eb821f9d0facc1f963f775c844c082aa301176705fd4163f6e6dfb0f758163fe9e9a8675f7370ec42a5adb1e4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
