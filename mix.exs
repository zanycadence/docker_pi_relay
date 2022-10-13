defmodule DockerPiRelay.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :docker_pi_relay,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:circuits_i2c, "~> 1.0"}
    ]
  end
end
