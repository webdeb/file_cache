defmodule FileCache.MixProject do
  use Mix.Project

  def project do
    [
      app: :file_cache,
      version: "0.2.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp description do
    """
    Store and load data from file system
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Boris Kotov"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/webdeb/file_cache"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:benchee, "~> 0.11", only: :dev},
      {:ex_doc, "~> 0.18", only: :dev},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false}
    ]
  end
end
