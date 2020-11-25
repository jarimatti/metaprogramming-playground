defmodule Metaprogramming.MessageDSL do
  @doc false
  defmacro __using__(_opts) do
    quote do
      import Metaprogramming.MessageDSL

      Module.register_attribute(__MODULE__, :message_types, accumulate: true, persists: true)

      @before_compile Metaprogramming.MessageDSL
    end
  end

  @doc """
  Define a new message with given name and payload type.
  """
  defmacro defmessage(module, value) do
    quote do
      defmodule unquote(module) do
        defstruct [:message_id, :from, :to]

        @type t() :: %__MODULE__{
          message_id: String.t(),
          from: unquote(value),
          to: unquote(value)
        }
      end

      @message_types unquote(module)
    end
  end

  defmacro defmessages(do: {:__block__, _, _} = block) do
    quote do
      unquote(block)
    end
  end

  defmacro __before_compile__(env) do
    t =
      env.module
      |> Module.get_attribute(:message_types)
      |> Enum.reject(&(&1 == env.module))
      |> type()

    quote do
      @type t() :: unquote(t)

      Module.delete_attribute(__MODULE__, :message_types)
    end
  end

  def type(modules) do
    modules
    |> Enum.map(&module_type/1)
    |> Enum.reduce(&or_type/2)
  end

  def module_type(module) do
    split =
      module
      |> Module.split()
      |> Enum.map(&String.to_existing_atom/1)
    {{:., [], [{:__aliases__, [alias: false], split}, :t]}, [], []}
  end

  def or_type(elem, acc) do
    {:|, [], [elem, acc]}
  end

end
