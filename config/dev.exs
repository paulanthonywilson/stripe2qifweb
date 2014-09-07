use Mix.Config

config :phoenix, Stripe2qifweb.Router,
  port: System.get_env("PORT") || 4000,
  ssl: false,
  host: "localhost",
  cookies: true,
  session_key: "_stripe2qifweb_key",
  session_secret: "=&XKL8Z+G+%8OF0C)Z5RE9*Z+5N*#!)!LNY1UIS9JQN=TG11DOFY6=7EQB_Y^19F&1QD",
  debug_errors: true

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


