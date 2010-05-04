# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_httpdocs_session',
  :secret      => 'bf6e796c66a415d31fc3023b48348c4dae32fc37affbb8149baef4803394ce5b76d7ecf5d724cb5356b76bd460f2f8ba491f373ff228b8d7cdff2477e1087c5a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
