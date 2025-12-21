defmodule Termex.ANSI do
  @moduledoc """
  This module contains helpers for building a styled input.

  You should chain the functions in order to use them:

  see `/examples/demo.exs`.
  """

  defstruct styles: []

  # Style	    ANSI Code
  # reset     	\e[0m
  # bold	    \e[1m
  # underline	\e[4m
  # blink     	\e[5m
  # reverse	    \e[7m
  # crossed     \e[9m
  defp seq(:reset), do: "0"
  defp seq(:bold), do: "1"
  defp seq(:italic), do: "3"
  defp seq(:underline), do: "4"
  defp seq(:blink), do: "5"
  defp seq(:reverse), do: "7"
  defp seq(:crossed), do: "9"

  @doc """
  Sets the style to bold.
  """
  def bold(%{styles: styles} = style \\ %__MODULE__{}), do: %{style | styles: [:bold | styles]}

  @doc """
  Sets the style to italic.
  """
  def italic(%{styles: styles} = style \\ %__MODULE__{}), do: %{style | styles: [:italic | styles]}

  @doc """
  Sets the style to underline.
  """
  def underline(%{styles: styles} = style \\ %__MODULE__{}), do: %{style | styles: [:underline | styles]}
  
  @doc """
  Sets the style to blink.
  """
  def blink(%{styles: styles} = style \\ %__MODULE__{}), do: %{style | styles: [:blink | styles]}
  
  @doc """
  Sets the style to reverse.
  """
  def reverse(%{styles: styles} = style \\ %__MODULE__{}), do: %{style | styles: [:reverse | styles]}
  
  @doc """
  Sets the style to crossed.
  """
  def crossed(%{styles: styles} = style \\ %__MODULE__{}), do: %{style | styles: [:crossed | styles]}

  @doc """
  Resets all styles, i suggest using it as an after.

  Called by Termex.Terminal.restore/0
  """
  def reset(), do: "\e[0m"
  
  def render(text, %__MODULE__{styles: []}) do
	text
  end

  @doc """
  Build the string using the styles and the ANSI codification.  
  """
  def render(text, style = %__MODULE__{}) do
	s =	style.styles |> Enum.sort() |> Enum.map(&seq/1) |> Enum.join(";")

	"\e[" <> s <> "m" <> text <> reset()
  end

end

