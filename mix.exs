defmodule LocalTimestamps.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :local_timestamps,
      version: @version,
      elixir: "~> 1.6",
      description: "Generate Ecto timestamps in local time",
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Simon McConnell"],
      license: ["MIT"],
      links: %{GitHub: "https://github.com/simonmcconnell/local_timestamps"}
    ]
  end

  defp deps do
    [
      {:timex, "~> 3.6"},
      {:ex_doc, "~> 0.13", only: [:docs]}
    ]
  end

  defp docs do
    [
      main: "LocalTimestamp",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/local_timestamps",
      source_url: "https://github.com/simonmcconnell/local_timestamps",
    ]
  end
end
