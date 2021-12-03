defmodule AdventOfCode2021.Day1 do
  @moduledoc """
  Advent of Code 2021
  Day 1
  """

  @spec part1() :: integer
  def part1() do
    "./assets/day1.txt"
    |> read_measurements()
    |> count_of_increased_measurements(0)
  end

  @spec read_measurements(String.t()) :: [integer]
  def read_measurements(filename) do
    filename
    |> File.read!()
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  @spec count_of_increased_measurements([integer], integer) :: integer
  def count_of_increased_measurements([_m1 | []], count), do: count

  def count_of_increased_measurements([m1, m2 | rest], count) when m1 < m2 do
    count_of_increased_measurements([m2 | rest], count + 1)
  end

  def count_of_increased_measurements([_m1 | rest], count) do
    count_of_increased_measurements(rest, count)
  end

  @spec part2() :: integer
  def part2() do
    "./assets/day1.txt"
    |> read_measurements()
    |> count_of_increased_sums(0)
  end

  @spec count_of_increased_sums([integer], integer) :: integer
  def count_of_increased_sums([_m1 | []], count), do: count
  def count_of_increased_sums([_m1, _m2 | []], count), do: count
  def count_of_increased_sums([_m1, _m2, _m3 | []], count), do: count

  def count_of_increased_sums([m1, m2, m3, m4 | rest], count) when m1 + m2 + m3 < m2 + m3 + m4 do
    count_of_increased_sums([m2, m3, m4 | rest], count + 1)
  end

  def count_of_increased_sums([_m1, m2, m3, m4 | rest], count) do
    count_of_increased_sums([m2, m3, m4 | rest], count)
  end
end
