defmodule FileCache.GSHelper do
  @moduledoc """
  This module helps to store and load your GenServer state automatically.

  Use it inside your GenServer like

      defmodule MyGenServer do
        use GenServer
        use FileCache.GSHelper, [id: :my_state]
      end

  It will define two callbacks automatically for you,
  which will store the state when in the terminate/2 callback,
  and restore it in the init/1 callback

  However, of course you can override them if you like. And implement the logic for storing and loading yourself.
  This is what the `use FileCache.GSHelper id: :my_state` will add under the hood

      defmodule MyGenServer do
        use GenServer

        def start_link(), do: ...
        def init(args) do
          {:ok, FileCache.load(:my_state) || args}
        end

        def terminate(_reason, state) do
          FileCache.store(:my_state, state)
        end
      end
  """

  defmacro __using__(id: id) do
    quote do
      def terminate(_reason, state) do
        FileCache.store(unquote(id), state)
      end

      def init(init_state) do
        {:ok, get_state_from_cache() || init_state}
      end

      defp get_state_from_cache() do
        FileCache.load(unquote(id))
      end

      defoverridable terminate: 2, init: 1
    end
  end
end
