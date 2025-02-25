defmodule AocDay2 do
  def aoc_1(v) do
    read_file(v)
    |> elem(1)
    |> AocTools.string_to_numbergrid()
    |> Enum.count(&safe_record?/1)
  end

  def read_file(:test) do
    File.read("data/data_02_2024_test.txt")
  end

  def read_file(:main) do
    File.read("data/data_02_2024.txt")
  end

  def safe_record?([head | rest]) do
    differences =
      Enum.zip([head | rest], rest)
      |> Enum.map(fn {x, y} -> x - y end)

    Enum.all?(differences, fn x -> x >= -3 and x <= -1 end) or
      Enum.all?(differences, fn x -> x >= 1 and x <= 3 end)
  end

  def aoc_2(v) do
    read_file(v)
    |> elem(1)
    |> AocTools.string_to_numbergrid()
    |> Enum.count(&safe_record_with_dampener?/1)
  end

  def safe_record_with_dampener?(record) do
    Enum.map(0..length(record), fn x -> List.delete_at(record, x) end)
    |> Enum.map(&AocDay2.safe_record?/1)
    |> Enum.any?()
  end
end
