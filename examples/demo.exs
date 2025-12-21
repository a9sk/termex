defmodule Demo do
  alias Termex.Terminal
  alias Termex.ANSI
  
  @x_start 10
  @y_start 10
  @bottom_line 25

  def start do
	Terminal.init()
	
	try do
	  Terminal.clear()

	  prompt_char() # i do not clear the screen only to use the |>
	  |> draw_pattern()
	  
	  style =
		ANSI.bold()
	    |> ANSI.crossed()
	    |> ANSI.italic()

	  prompt_string()
	  |> ANSI.render(style)
	  |> Terminal.write()

	  Terminal.move_cursor(@x_start, @y_start + 1)
	  Terminal.write("<")
	  for i <- 0..20 do
		Terminal.write("-")
		:timer.sleep(7)
	  end

  	  Terminal.write("HERE!!!")
	  
	  Terminal.move_cursor(0, @bottom_line)
	after
	  Terminal.restore()
	end	
  end

  defp draw_pattern(c) do
	for y <- 0..9 do
		for x <- 0..20 do
			Terminal.move_cursor(@x_start + x, @y_start + y)
			Terminal.write(c)
			:timer.sleep(5)
		end
	end
  end

  defp prompt_char do
	Terminal.move_cursor(@x_start, @y_start)
	Terminal.write("Insert a character: ")
	Terminal.read_key()
  end

  defp prompt_string do
	Terminal.move_cursor(@x_start + 25, @y_start)
	Terminal.write("Insert a string: ")
	Terminal.read_until_enter()
  end

  
end

Demo.start()
