defmodule AocDay4 do
  def aoc_1(v) do
    read_file(v)
    |> Enum.map(&String.to_charlist/1)
    |> count_xmas
  end

  def read_file(:test) do
    File.stream!("data/data_04_2024_test.txt", :line)
    |> Enum.map(&String.trim/1)
  end

  def read_file(:main) do
    File.stream!("data/data_04_2024.txt", :line)
    |> Enum.map(&String.trim/1)
  end

  def count_xmas(charlists) do
    Enum.sum([
      count_horizontal(charlists),
      count_diagonal(charlists),
      count_horizontal(AocTools.rotate(charlists)),
      count_diagonal(AocTools.rotate(charlists)),
      count_horizontal(AocTools.rotate(AocTools.rotate(charlists))),
      count_diagonal(AocTools.rotate(AocTools.rotate(charlists))),
      count_horizontal(AocTools.rotate(AocTools.rotate(AocTools.rotate(charlists)))),
      count_diagonal(AocTools.rotate(AocTools.rotate(AocTools.rotate(charlists))))
    ])
  end

  def count_horizontal(charlists) do
    Enum.map(charlists, &count_horizontal_xmas/1)
    |> Enum.sum()
  end

  def count_horizontal_xmas([h | b]) do
    cond do
      List.starts_with?([h | b], ~c"XMAS") ->
        count_horizontal_xmas(b) + 1

      true ->
        count_horizontal_xmas(b)
    end
  end

  def count_horizontal_xmas([]), do: 0

  def count_diagonal([r1, r2, r3, r4 | r]) do
    count_diagonal_xmas([r1, r2, r3, r4]) + count_diagonal([r2, r3, r4 | r])
  end

  def count_diagonal([_, _, _]), do: 0

  def count_diagonal_xmas([
        [?X, h12, h13, h14 | r1],
        [_h21, ?M, h23, h24 | r2],
        [_h31, h32, ?A, h34 | r3],
        [_h41, h42, h43, ?S | r4]
      ]) do
    count_diagonal_xmas([
      [h12, h13, h14 | r1],
      [?M, h23, h24 | r2],
      [h32, ?A, h34 | r3],
      [h42, h43, ?S | r4]
    ]) + 1
  end

  def count_diagonal_xmas([
        [_h11, h12, h13, h14 | r1],
        [_h21, h22, h23, h24 | r2],
        [_h31, h32, h33, h34 | r3],
        [_h41, h42, h43, h44 | r4]
      ]) do
    count_diagonal_xmas([
      [h12, h13, h14 | r1],
      [h22, h23, h24 | r2],
      [h32, h33, h34 | r3],
      [h42, h43, h44 | r4]
    ])
  end

  def count_diagonal_xmas([[_, _, _], [_, _, _], [_, _, _], [_, _, _]]), do: 0

  def aoc_2(v) do
    read_file(v)
    |> Enum.map(&String.to_charlist/1)
    |> count_x_mas
  end

  def count_x_mas(charlists) do
    Enum.sum([
      count_x_mas_(charlists),
      count_x_mas_(AocTools.rotate(charlists)),
      count_x_mas_(AocTools.rotate(AocTools.rotate(charlists))),
      count_x_mas_(AocTools.rotate(AocTools.rotate(AocTools.rotate(charlists))))
    ])
  end

  def count_x_mas_([r1, r2, r3 | r]) do
    count_x_mas_1([r1, r2, r3]) + count_x_mas_([r2, r3 | r])
  end

  def count_x_mas_([_, _]), do: 0

  def count_x_mas_1([
        [?M, h12, ?S | r1],
        [_h21, ?A, h23 | r2],
        [?M, h32, ?S | r3]
      ]) do
    1 +
      count_x_mas_1([
        [h12, ?S | r1],
        [?A, h23 | r2],
        [h32, ?S | r3]
      ])
  end

  def count_x_mas_1([
        [_h11, h12, h13 | r1],
        [_h21, h22, h23 | r2],
        [_h31, h32, h33 | r3]
      ]) do
    count_x_mas_1([
      [h12, h13 | r1],
      [h22, h23 | r2],
      [h32, h33 | r3]
    ])
  end

  def count_x_mas_1([[_, _], [_, _], [_, _]]), do: 0
end
