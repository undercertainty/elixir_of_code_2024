defmodule AocDay5 do
  def aoc_1(v) do
    read_file(v)
    |> parse_input
    |> solve_part_1
  end

  def read_file(:test) do
    File.stream!("data/data_05_2024_test.txt", :line)
    |> Enum.map(&String.trim/1)
  end

  def read_file(:main) do
    File.stream!("data/data_05_2024.txt", :line)
    |> Enum.map(&String.trim/1)
  end

  def parse_input(strings) do
    %{
      :graph =>
        Enum.take_while(strings, fn x -> x != "" end)
        |> parse_order_rules,
      :pages => parse_pages(Enum.drop_while(strings, fn x -> x != "" end))
    }
  end

  def parse_order_rules(lines) do
    pairs = Enum.map(lines, fn x -> Regex.scan(~r/\d+/, x) end)

    Enum.map(pairs, fn [[n1], [n2]] -> {String.to_integer(n1), String.to_integer(n2)} end)
  end

  def parse_pages([_ | lines]) do
    Enum.map(lines, fn x ->
      Enum.map(String.split(x, ","), &String.to_integer/1)
    end)
  end

  def cmp(x, y, g) do
    cmp_([x], y, [], g)
  end

  def cmp_([], _, _, _) do
    false
  end

  def cmp_([x | _], x, _, _) do
    true
  end

  def cmp_([x | r], target, visited, g) do
    cond do
      Enum.member?(visited, x) ->
        cmp_(r, target, visited, g)

      true ->
        next =
          Enum.filter(g, fn {y, _z} -> y == x end)
          |> Enum.map(fn z -> elem(z, 1) end)

        cmp_(Enum.uniq(next ++ r), target, [x | visited], g)
    end
  end

  def correctly_sorted(numbers, graph) do
    # Restrict graph to terms in the list, because I
    # think there are loops in the main set

    restricted_graph =
      Enum.filter(graph, fn {x, y} -> Enum.member?(numbers, x) and Enum.member?(numbers, y) end)

    numbers == Enum.sort(numbers, fn x, y -> cmp(x, y, restricted_graph) end)
  end

  def solve_part_1(%{graph: graph, pages: pages}) do
    Enum.filter(pages, fn l -> correctly_sorted(l, graph) end)
    |> Enum.map(fn l -> Enum.at(l, div(length(l), 2)) end)
    |> Enum.sum()
  end

  def aoc_2(v) do
    read_file(v)
    |> parse_input
    |> solve_part_2
  end

  def solve_part_2(%{graph: graph, pages: pages}) do
    sort_compare = fn x, y -> cmp(x, y, graph) end

    Enum.filter(pages, fn l -> not correctly_sorted(l, graph) end)
    |> Enum.map(fn l -> Enum.sort(l, sort_compare) end)
    |> Enum.map(fn l -> Enum.at(l, div(length(l), 2)) end)
    |> Enum.sum()
  end
end
