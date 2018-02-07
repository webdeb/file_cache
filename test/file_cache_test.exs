defmodule FileCacheTest do
  use ExUnit.Case
  doctest FileCache

  setup_all ctx do
    on_exit(ctx, fn -> FileCache.clear() end)
  end

  test "stores and loads DATA" do
    FileCache.store(:test, "DATA")
    assert FileCache.load(:test) === "DATA"
  end

  test "loads nil if not available" do
    assert FileCache.load(:test_nil) === nil
  end
end
