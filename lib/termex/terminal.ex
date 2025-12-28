defmodule Termex.Terminal do
  @moduledoc """
  This module contains the public API for the Termex minimal terminal wrapper.
  """

  @doc """
  Enter raw mode (not on tty) + hide cursor + prepare state.
  
  This should not affect the OS terminal driver so it will probably not work.
  """
  def init do
	# System.cmd("stty", ["-echo", "-icanon", "min", "1", "time", "0"])
	_ = :io.setopts(:stdio, [:binary, {:echo, false}, {:line, 0}])
	hide_cursor()
	:ok
  end

  @doc """
  Restore cooked mode  (not on tty) + show cursor + reset ANSI state.

  I suggest putting this as an after to the whole code using this module.
  """
  def restore do
	# System.cmd("stty", ["echo", "icanon"])
	_ = :io.setopts(:stdio, [:binary, {:echo, true}, {:line, 1}])
	show_cursor()
	:ok	
  end

  @doc """
  Write text calling Termex.ANSI for formatting.
  """
  def write(text) do
	IO.write(text)
  end

  @doc """
  Clear screen using Termex.ANSI.clear_screen.
  """
  def clear do
	IO.write("\e[2J\e[H")
  end

  @doc """
  Move cursor to (x, y).
  """
  def move_cursor(x, y) do
	IO.write("\e[#{y};#{x}H") # \e[<row>;<col>H
  end

  @doc """
  Yeah this hides the cursor.
  """
  def hide_cursor do
	IO.write("\e[?25l")
  end

  @doc """
  You won't guess what this function does.
  """
  def show_cursor do
	IO.write("\e[?25h")
  end

  @doc """
  Reads a single character from stdin.
  """
  def read_key do
	case IO.read(:stdio, 1) do
	  :eof -> nil
	  char ->
		IO.read(:stdio, :line) # flush rest of chars
	  	char
	end

  end

  @doc """
  Reads and returns a full stdio line.
  """
  def read_until_enter do
	case IO.read(:stdio, :line) do
	  :eof -> nil
	  word -> word
	end
  end

  @doc """
  Returns terminal size as {width, height}.
  """
  def size do
	{:ok, cols} = :io.columns(:stdio)
	{:ok, rows} = :io.rows(:stdio)
	{cols, rows}
  end

  
end
