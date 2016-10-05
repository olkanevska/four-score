defmodule Game.IO do
  def get_string(prompt) do
    case prompt |> IO.gets |> String.trim do
      ""  -> get_string(prompt)
      str -> str
    end
  end

  def get_num(prompt, min, max) do
    case prompt |> get_string |> Integer.parse do
      {int, _} when int in min..max -> int
      _ -> get_num(prompt, min, max)
    end
  end
end
