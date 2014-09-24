# Be sure to restart your server when you modify this file.

# CharlesEllsworth::Application.config.session_store :cookie_store, key: '_charles_ellsworth_session'
CharlesEllsworth::Application.config.session_store :active_record_store
ActiveRecord::SessionStore::Session.attr_accessible :data, :session_id
