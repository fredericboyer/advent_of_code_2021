defmodule AdventOfCode2021.Day2 do
  @moduledoc """
  Advent of Code 2021
  Day 2
  """

  @spec part1() :: integer
  def part1() do
    "./assets/day2.txt"
    |> read_commands()
    |> follow_planned_course()
    |> multiply_h_pos_by_depth()
  end

  @spec read_commands(String.t()) :: [{String.t(), pos_integer}]
  def read_commands(filename) do
    filename
    |> File.read!()
    |> String.split("\n")
    |> Stream.map(&String.split/1)
    |> Stream.map(&List.to_tuple/1)
    |> Enum.map(fn {dir, units} -> {dir, String.to_integer(units)} end)
  end

  @spec follow_planned_course([{String.t(), pos_integer}]) :: %{h_pos: integer, depth: integer}
  def follow_planned_course(commands) do
    Enum.reduce(commands, %{h_pos: 0, depth: 0}, &move(&1, &2))
  end

  @spec move({String.t(), pos_integer}, %{h_pos: integer, depth: integer}) :: %{
          h_pos: integer,
          depth: integer
        }
  def move({"forward", units}, %{h_pos: h, depth: d}), do: %{h_pos: h + units, depth: d}
  def move({"up", units}, %{h_pos: h, depth: d}), do: %{h_pos: h, depth: d - units}
  def move({"down", units}, %{h_pos: h, depth: d}), do: %{h_pos: h, depth: d + units}

  @spec multiply_h_pos_by_depth(map) :: integer
  def multiply_h_pos_by_depth(%{h_pos: h, depth: d}), do: h * d

  @spec part2() :: integer
  def part2() do
    "./assets/day2.txt"
    |> read_commands()
    |> follow_adjusted_planned_course()
    |> multiply_h_pos_by_depth()
  end

  @spec follow_adjusted_planned_course([{String.t(), pos_integer}]) :: %{
          h_pos: integer,
          depth: integer,
          aim: integer
        }
  def follow_adjusted_planned_course(commands) do
    Enum.reduce(commands, %{h_pos: 0, depth: 0, aim: 0}, &adjusted_move(&1, &2))
  end

  @spec adjusted_move({String.t(), pos_integer}, %{h_pos: integer, depth: integer, aim: integer}) ::
          %{
            h_pos: integer,
            depth: integer,
            aim: integer
          }
  def adjusted_move({"forward", units}, %{h_pos: h, depth: d, aim: a}),
    do: %{h_pos: h + units, depth: d + units * a, aim: a}

  def adjusted_move({"up", units}, %{h_pos: h, depth: d, aim: a}),
    do: %{h_pos: h, depth: d, aim: a - units}

  def adjusted_move({"down", units}, %{h_pos: h, depth: d, aim: a}),
    do: %{h_pos: h, depth: d, aim: a + units}
end
