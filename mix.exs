defmodule Fourscore.Mixfile do
  use Mix.Project

  def project, do: [
    app: :fourscore,
    version: "0.1.0",
    elixir: "~> 1.3",
    build_embedded: Mix.env == :prod,
    start_permanent: Mix.env == :prod,
    deps: deps()
  ]

  def application, do: [applications: [:logger]]

  defp deps, do: []
end
