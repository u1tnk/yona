# Be sure to restart your server when you modify this file.

# cookieがexpire=現在時間で発行されるので一旦cache_storeに変更
Yona::Application.config.session_store :cookie_store, key: '_yona_session'
# Yona::Application.config.session_store :cache_store, key: '_yona_session'
