defmodule AocTools do
  def string_to_numbergrid(str) do
    String.trim(str)
    |> String.split(~r(\n))
    |> Enum.map(&string_to_numberlist/1)
  end

  def string_to_numberlist(str) do
    String.trim(str)
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end
