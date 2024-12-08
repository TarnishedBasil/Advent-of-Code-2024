
{list1, list2} = File.stream!("input.txt")
                  |> Enum.reduce({[],[]},fn line, {acc1, acc2} ->
                    [elem1, elem2] = line
                            |> String.trim()
                            |> String.split("   ")
                            |> Enum.map(&Integer.parse(&1))
                            |> Enum.map(fn {num, _} -> num end)
                            { [elem1 | acc1], [elem2 | acc2]}
                  end)

map = Enum.reduce(list2, %{}, fn x, acc ->
  value = Map.get(acc, x, 0)
  new_value = value + 1
  Map.put(acc, x, new_value)
end)

#IO.inspect(map)

result = Enum.reduce(list1, 0, fn x, acc ->
  acc + (x * Map.get(map, x, 0))
end)

IO.puts(result)
