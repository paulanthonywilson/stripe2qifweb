defmodule Stripe2qifweb.Mixfile do
  use Mix.Project

  def project do
    [ app: :stripe2qifweb,
      version: "0.0.1",
      elixir: "~> 1.0.0",
      elixirc_paths: ["lib", "web"],
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Stripe2qifweb, [] },
      applications: [:phoenix, :cowboy, :logger, :httpotion]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:phoenix, "0.4.0"},
      {:cowboy, "~> 1.0.0"},
      { :stripe2qif, github: "paulanthonywilson/stripe2qif"},
    ]
  end
end
