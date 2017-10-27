defmodule Player do
  defstruct name: nil, token: nil

  def new(name, token) do
    %Player{name: name, token: token}
  end

  def to_string(player) do
    "[#{player.token}] #{player.name}"
  end
end
