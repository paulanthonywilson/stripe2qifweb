defmodule Stripe2qifweb.Mixfile do
  use Mix.Project

  def project do
    [ app: :stripe2qifweb,
      version: "0.0.1",
      build_per_environment: true,
      dynamos: [Stripe2qifweb.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo],
      mod: { Stripe2qifweb, [] } ]
  end

  defp deps do
    [ { :cowboy, github: "extend/cowboy" },
      { :dynamo, "~> 0.1.0-dev", github: "elixir-lang/dynamo" } ]
  end
end
