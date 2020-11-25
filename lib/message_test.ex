defmodule Metaprogramming.MessageTest do
  use Metaprogramming.MessageDSL

  defmessage(TestMessage, boolean())
  defmessage(StringMessage, String.t())
end
