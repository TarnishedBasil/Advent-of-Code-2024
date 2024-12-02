defmodule Day1 do
  use Application

  def start(_type, _args) do
    Day1.readFile("day1_input.txt")
    Supervisor.start_link([], strategy: :one_for_one)
  end

  def readFile(filename) do
    {list1, list2} = File.stream!(filename)
                      |> Enum.reduce({[],[]},fn line, {acc1, acc2} ->
                        [elem1, elem2] = line
                                |> String.trim()
                                |> String.split("   ")
                                |> Enum.map(&Integer.parse(&1))
                                |> Enum.map(fn {num, _} -> num end)
                                { [elem1 | acc1], [elem2 | acc2]}
                      end)

    sorted_list1 = Enum.sort(list1)
    sorted_list2 = Enum.sort(list2)


    #IO.inspect(sorted_list1)
    #IO.inspect(sorted_list2)

    sum = sumDistances(sorted_list1, sorted_list2)

    IO.puts(sum)
  end

  def sumDistances([], []), do: 0

  def sumDistances([head1 | tail1], [head2 | tail2]) do
    abs(head1 - head2) + sumDistances(tail1, tail2)
  end

end
