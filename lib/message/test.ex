defmodule Metaprogramming.Message.Test do
  @moduledoc """
  Messages are defined here.
  """
  use Metaprogramming.Message.DSL

  defmessage(TestMessage, boolean())
  defmessage(StringMessage, String.t())
end
