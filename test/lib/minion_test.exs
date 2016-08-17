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

  test "Can add to the count" do
    AssembleTheMinions.Minion.start_link(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.add(:kevin, 2)

    kevin_count = AssembleTheMinions.Minion.current_count(:kevin)
    assert kevin_count == 3
  end

  test "Can add negatives to the count" do
    AssembleTheMinions.Minion.start_link(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.add(:kevin, -2)

    kevin_count = AssembleTheMinions.Minion.current_count(:kevin)
    assert kevin_count == -1
  end

  test "Can subtract from the count" do
    AssembleTheMinions.Minion.start_link(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.subtract(:kevin, 2)

    kevin_count = AssembleTheMinions.Minion.current_count(:kevin)
    assert kevin_count == 1
  end

  test "Can subtract negatives from the count" do
    AssembleTheMinions.Minion.start_link(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.subtract(:kevin, -2)

    kevin_count = AssembleTheMinions.Minion.current_count(:kevin)
    assert kevin_count == 5
  end

  test "Can multiply the count by a given factor" do
    AssembleTheMinions.Minion.start_link(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.multiply(:kevin, 2)

    kevin_count = AssembleTheMinions.Minion.current_count(:kevin)
    assert kevin_count == 4
  end

  test "Can multiply the count by a negative factor" do
    AssembleTheMinions.Minion.start_link(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.multiply(:kevin, -2)

    kevin_count = AssembleTheMinions.Minion.current_count(:kevin)
    assert kevin_count == -4
  end

  test "Can divide the count by a given divisor" do
    AssembleTheMinions.Minion.start_link(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.divide(:kevin, 2)

    kevin_count = AssembleTheMinions.Minion.current_count(:kevin)
    assert kevin_count == 2
  end

  test "Can divide the count by a negative divisor" do
    AssembleTheMinions.Minion.start_link(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.count(:kevin)
    AssembleTheMinions.Minion.divide(:kevin, -2)

    kevin_count = AssembleTheMinions.Minion.current_count(:kevin)
    assert kevin_count == -2
  end
end
