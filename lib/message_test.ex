defmodule Metaprogramming.MessageTest do
  use Metaprogramming.MessageDSL

  defmessages do
    defmessage(TestMessage, boolean())
    defmessage(StringMessage, String.t())
  end
end
