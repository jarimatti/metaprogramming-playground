defmodule Metaprogramming.Message.Client do
  @moduledoc """
  A client module using the defined messages.

  This is used to test and show that the type
  `Metaprogramming.Message.Test.t()` is generated correctly.
  """
  alias Metaprogramming.Message.Test

  @spec handle(Test.t()) :: String.t()
  def handle(%Test.StringMessage{}) do
    "string message"
  end

  def handle(%Test.TestMessage{}) do
    "string message"
  end

  @spec stuff :: String.t()
  def stuff do
    handle(%Test.StringMessage{from: "hello", message_id: "id-1", to: "foobar"})
  end
end
