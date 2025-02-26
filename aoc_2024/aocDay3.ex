defmodule AocDay3 do
  def aoc_1(v) do
    read_file(v)
    |> elem(1)
    |> parse_input
  end

  def read_file(:test) do
    File.read("data/data_03_2024_test.txt")
  end

  def read_file(:test2) do
    File.read("data/data_03_2024_testb.txt")
  end

  def read_file(:main) do
    File.read("data/data_03_2024.txt")
  end

  def parse_input(string) do
    Regex.scan(~r/mul\((\d+)\,(\d+)\)/, string)
    |> Enum.map(fn [_, x, y] -> AocTools.string_to_int(x) * AocTools.string_to_int(y) end)
    |> Enum.sum()
  end

  def aoc_2(v) do
    read_file(v)
    |> elem(1)
    |> remove_disabled_instructions
    |> parse_input
  end

  def remove_disabled_instructions(string) do
    split_input = Regex.split(~r/(don't\(\))|(do\(\))/, string, include_captures: true)

    remove_disabled_instructions_(split_input)
  end

  def remove_disabled_instructions_(list) do
    Enum.zip(["do()" | list], list)
    |> Enum.filter(fn {h, _} -> h == "do()" end)
    |> Enum.map(fn {_, b} -> b end)
    |> Enum.join()
  end
end
