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

  def transpose([grid | grids]) do
    Enum.map(0..(length(grid) - 1), fn x ->
      Enum.map([grid | grids], fn y -> Enum.at(y, x) end)
    end)
  end

  def rotate(grid) do
    transpose(grid)
    |> Enum.map(&Enum.reverse/1)
  end
end
