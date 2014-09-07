# This file is responsible for configuring your application
use Mix.Config

# Note this file is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project.

config :phoenix, Stripe2qifweb.Router,
  port: System.get_env("PORT"),
  ssl: false,
  static_assets: true,
  cookies: true,
  session_key: "_stripe2qifweb_key",
  session_secret: "=&XKL8Z+G+%8OF0C)Z5RE9*Z+5N*#!)!LNY1UIS9JQN=TG11DOFY6=7EQB_Y^19F&1QD",
  catch_errors: true,
  debug_errors: false,
  error_controller: Stripe2qifweb.PageController

config :phoenix, :code_reloader,
  enabled: false

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
