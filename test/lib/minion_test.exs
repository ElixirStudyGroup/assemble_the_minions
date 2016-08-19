defmodule AssembleTheMinions.MinionTest do
  use ExUnit.Case
  doctest AssembleTheMinions.Minion

  test "Returns a hello message" do
    AssembleTheMinions.Minion.start_link(:kevin)

    message = AssembleTheMinions.Minion.say_hello(:kevin)

    assert message == "Hello from kevin"
  end

  test "Can return the count and increment it" do
    AssembleTheMinions.Minion.start_link(:jorge)

    count = AssembleTheMinions.Minion.current_count(:jorge)

    assert count == 0

    AssembleTheMinions.Minion.count(:jorge)

    second_count = AssembleTheMinions.Minion.current_count(:jorge)

    assert second_count == 1
  end

  test "Changing on minion's count doesn't affect another's" do
    AssembleTheMinions.Minion.start_link(:kevin)
    AssembleTheMinions.Minion.start_link(:jorge)

    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)

    kevin_count = AssembleTheMinions.Minion.current_count(:kevin)
    jorge_count = AssembleTheMinions.Minion.current_count(:jorge)

    assert jorge_count == 0

    assert kevin_count == 2
  end

  test "minions can add to their count" do
    AssembleTheMinions.Minion.start_link(:kevin)

    AssembleTheMinions.Minion.add(:kevin, 1)
    assert AssembleTheMinions.Minion.current_count(:kevin) == 1

    AssembleTheMinions.Minion.add(:kevin, -2)
    assert AssembleTheMinions.Minion.current_count(:kevin) == -1
  end

  test "minions can subtract from their count" do
    AssembleTheMinions.Minion.start_link(:kevin)

    AssembleTheMinions.Minion.subtract(:kevin, 10)
    assert AssembleTheMinions.Minion.current_count(:kevin) == -10
  end

  test "minions can multiply their count" do
    AssembleTheMinions.Minion.start_link(:kevin)

    AssembleTheMinions.Minion.count(:kevin)
    assert AssembleTheMinions.Minion.current_count(:kevin) == 1

    AssembleTheMinions.Minion.multiply(:kevin, 10)
    assert AssembleTheMinions.Minion.current_count(:kevin) == 10

    AssembleTheMinions.Minion.multiply(:kevin, -2)
    assert AssembleTheMinions.Minion.current_count(:kevin) == -20
  end

  test "minions can divide their count" do
    AssembleTheMinions.Minion.start_link(:kevin)

    AssembleTheMinions.Minion.add(:kevin, 10)
    assert AssembleTheMinions.Minion.current_count(:kevin) == 10

    AssembleTheMinions.Minion.divide(:kevin, 2)
    assert AssembleTheMinions.Minion.current_count(:kevin) == 5

    AssembleTheMinions.Minion.divide(:kevin, 0.5)
    assert AssembleTheMinions.Minion.current_count(:kevin) == 10
  end
end
