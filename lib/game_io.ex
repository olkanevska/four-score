defmodule Game.IO do
  def get_string(string), do: string |> IO.gets |> String.trim

  def get_num(string, min, max) do
    get_string(string)
    |> Integer.parse
    |> check_num(min, max, string)
  end

  defp check_num({int, _}, min, max, _string) when int >= min and int <= max do
    int
  end

  defp check_num(_, min, max, string) do
    get_num(string, min, max)
  end
end
