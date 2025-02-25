defmodule AocTools do
  def string_to_numbergrid(str) do
    String.trim(str)
    |> String.split(~r(\n))
    |> Enum.map(&string_to_numberlist/1)
  end

  def string_to_numberlist(str) do
    String.trim(str)
    |> String.split()
    |> Enum.map(&string_to_int/1)
  end

  def string_to_int(string) do
    Integer.parse(string) |> elem(0)
  end

  def t() do
    File.read("data/data_02_2024_test.txt")
    |> elem(1)
    |> string_to_numbergrid()
  end
end
