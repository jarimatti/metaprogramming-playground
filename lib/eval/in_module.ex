defmodule Metaprogramming.Eval.InModule do
  IO.puts("Hi there, this is from module body. I'm evaluated at compile time.")

  defmodule Stuff do
    @spec generate_foobar(any) ::
            {:__block__, [], [{:@, [...], [...]} | {:def, [...], [...]}, ...]}
    def generate_foobar(arg) do
      quote do
        def foobar do
          IO.puts("I'm generated foobar. #{inspect(unquote(arg))}")
        end

        @type t() :: String.t() | number()
      end
    end
  end

  Module.eval_quoted(
    __MODULE__,
    Stuff.generate_foobar(1 + 2)
  )

  @spec hello(t()) :: :ok
  def hello(name) do
    IO.puts("Hi, I'm the function body. #{inspect(name)}")
  end
end
