item = %{
  prop_1: 1,
  prop_2: 12345678907896,
  prop_2: "asdfasdf-asdfasdfasd-asdfasdfas-asdfasdfasdf-asdfasfas"
}

Benchee.run(%{
  "load 10_000" => fn ->
    FileCache.load(:bench_10_000)
  end,
  "load 1_000_000" => fn ->
    FileCache.load(:bench_1_000_000)
  end,
  "store 10_000" => fn ->
    FileCache.store(:bench_10_000, List.duplicate(item, 10_000))
  end,
  "store 1_000_000" => fn ->
    FileCache.store(:bench_1_000_000, List.duplicate(item, 1_000_000))
  end,
})