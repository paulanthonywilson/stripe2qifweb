defmodule Stripe2qifweb.Router do
  use Phoenix.Router

  get "/", Stripe2qifweb.PageController, :index, as: :pages
  get "/qif", Stripe2qifweb.PageController, :qif

end
