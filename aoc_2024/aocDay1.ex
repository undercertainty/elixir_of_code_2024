defmodule AocDay1 do
  def aoc_1(v) do
    read_file(v)
    |> parse_file
    |> calculate_distance
  end

  def parse_file({:ok, str_in}) do
    String.trim(str_in)
    |> String.split(~r(\n))
    |> Enum.map(&String.split/1)
    |> Enum.reduce([[], []], fn [x, y], [xs, ys] ->
      [[String.to_integer(x) | xs], [String.to_integer(y) | ys]]
    end)
  end

  def read_file(:test) do
    File.read("data/data_01_2024_test.txt")
  end

  def read_file(:main) do
    File.read("data/data_01_2024.txt")
  end

  def calculate_distance([xs, ys]) do
    [Enum.sort(xs), Enum.sort(ys)]
    |> Enum.zip()
    |> Enum.map(fn {x, y} -> abs(x - y) end)
    |> Enum.sum()
  end

  def aoc_2(v) do
    read_file(v)
    |> parse_file
    |> calculate_similarity
  end

  def calculate_similarity([xs, ys]) do
    Enum.map(xs, fn x -> x * count_occurrences(x, ys) end)
    |> Enum.sum()
  end

  def count_occurrences(x, xs) do
    Enum.count(xs, fn y -> y == x end)
  end
end
