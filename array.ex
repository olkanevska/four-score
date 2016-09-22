defmodule Array do
  defstruct contents: nil

  def new(default \\ nil) do
    %Array{contents: :array.new(default: default)}
  end

  def is_array(%Array{}), do: true

  def is_array(_), do: false

  def size(%Array{contents: c}) do
    :array.size(c)
  end
end
