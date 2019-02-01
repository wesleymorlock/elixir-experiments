defmodule GenstageTutorialTest do
  use ExUnit.Case
  doctest GenstageTutorial

  test "greets the world" do
    assert GenstageTutorial.hello() == :world
  end
end
