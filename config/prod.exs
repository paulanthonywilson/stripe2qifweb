use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, Stripe2qifweb.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  cookies: true,
  session_key: "_stripe2qifweb_key",
  session_secret: "=&XKL8Z+G+%8OF0C)Z5RE9*Z+5N*#!)!LNY1UIS9JQN=TG11DOFY6=7EQB_Y^19F&1QD"

config :logger, :console,
  level: :info,
  metadata: [:request_id]

