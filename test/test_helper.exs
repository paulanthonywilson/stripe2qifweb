Dynamo.under_test(Stripe2qifweb.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule Stripe2qifweb.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
