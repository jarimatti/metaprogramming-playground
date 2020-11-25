defmodule Metaprogramming.Meta.Hygiene do
  defmacro no_interference do
    quote do: a = 1
  end

  defmacro interference do
    quote do: var!(a) = 1
  end
end

defmodule Metaprogramming.Meta.HygieneTest do
  def go do
    require Metaprogramming.Meta.Hygiene
    alias Metaprogramming.Meta.Hygiene
    a = 13
    Hygiene.interference()
    a
  end
end
