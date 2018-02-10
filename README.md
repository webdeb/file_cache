# FileCache

Simply store arbitrary data into files, it has just two functions, `store` & `load`

## Installation


```elixir
def deps do
  [
    {:file_cache, "~> 0.2.0"}
  ]
end
```

## Configuration

Set the path to the directory you would like to point to for your cache files, the default setting is:

```elixir
  config :file_cache, path: "/tmp/appcache"
```

## Usage

The data is stored into files in the bert format (Binary ERlang Term). Its very lightweight and optimized for the Erlang VM.

Use it so:

```elixir
FileCache.store(:my_data, %{})
```

This will create the BERT file in `/tmp/appcache/my_data`

```elixir
FileCache.load(:my_data)
# -> nil | %{}
```

## Use inside a GenServer

When you have to restart your Server, and you don't want to loose your state? Use the `FileCache.GSHelper`

```elixir
defmodule MyGS do
  use GenServer
  use FileCache.GSHelper, id: :my_special_state
end
```

The GenServer Helper will automaticall store your data in the `terminate` callback and it will try to load the state in the `init` callback on startup.

More infos and Docs [https://hexdocs.pm/file_cache](https://hexdocs.pm/file_cache).

