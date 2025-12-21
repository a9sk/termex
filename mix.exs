defmodule Termex.MixProject do
  use Mix.Project

  @source "https://github.com/a9sk/termex"
  @version "0.1.0"
  
  def project do
    [
      app: :termex,
	  description: "A very very basic wrapper for terminal manipulation in Elixir",
	  package: package(),
      version: @version,
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
	  name: "TermEx",
	  source_url: @source
	]
  end

  def application do
    []
  end

  defp package() do
	[
	  files: ~w(lib .formatter.exs mix.exs README.md LICENSE),
	  licenses: ["MIT"],
	  links: %{"GitHub" => @source},
	]
  end

  
  defp deps do
    [
	  {:ex_doc, "~> 0.34", only: :dev, runtime: false}
	]
  end
end
