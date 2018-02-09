defmodule GSHelperTest do
  use ExUnit.Case, async: false

  @test_cache_id :test_gs_state

  defmodule TestGS do
    @test_cache_id :test_gs_state

    use GenServer
    use FileCache.GSHelper, id: @test_cache_id
  
    def start() do
      GenServer.start_link(__MODULE__, [], name: __MODULE__)
    end
  
    def get() do
      GenServer.call(__MODULE__, :get)
    end
    def set(state) do
      GenServer.cast(__MODULE__, {:set, state})
    end
    def stop() do
      GenServer.stop(__MODULE__)
    end
    def handle_cast({:set, state}, _) do
      {:noreply, state}
    end
    def handle_call(:get, _, state) do
      {:reply, state, state}
    end
  end
  
  setup do
    FileCache.remove(@test_cache_id)
  end

  test "starting for the first time: the cache should be empty" do
    assert FileCache.load(@test_cache_id) == nil
    {:ok, _} = TestGS.start()
  end

  test "stopping: the cache should've been written to the cache" do
    {:ok, _} = TestGS.start()
    :ok = TestGS.set(:test)
    :ok = TestGS.stop()

    assert FileCache.load(@test_cache_id) == :test
  end

  test "start when cache is not empty" do
    data = [:some_data, %{"a" => :b}]
    FileCache.store(@test_cache_id, data)
    {:ok, _} = TestGS.start()
    assert TestGS.get() == data
  end
end